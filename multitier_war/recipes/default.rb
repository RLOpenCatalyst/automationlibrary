# get the attributes assigned by db cookbook.
# get the war file
# deploy in tomcat node
# update the 

#same node: mysql attributes
#mysql user

#multi_node. data bag
db_recipe = search(:node, %Q{run_list:*multitier_war* AND run_list:*multitier_db* })

 mysql_user = %x(cut -d: -f1 /etc/passwd | grep '^mysql')

if !mysql_user.empty? || !db_recipe.empty?

  node.default[:multitier_war][:database][:server_ip] = "localhost"
  node.default[:multitier_war][:database][:server_port] = node[:mysql][:server_port]
  node.default[:multitier_war][:database][:db_name] = node[:multitier][:database_name]
  node.default[:multitier_war][:database][:db_user] = node[:multitier][:database_user]
  node.default[:multitier_war][:database][:db_password] = node[:multitier][:database_password]
else 
  db_server = search(:petclinic, "id:petclinic_app").first
  puts "search result: #{db_server[:ip]}"

  node.default[:multitier_war][:database][:server_ip] = db_server[:ip]
  node.default[:multitier_war][:database][:server_port] = db_server[:db_port]
  node.default[:multitier_war][:database][:db_name] = db_server[:db_name]
  node.default[:multitier_war][:database][:db_user] = db_server[:db_user]
  node.default[:multitier_war][:database][:db_password] = db_server[:db_password]
end

url = node[:rlcatalyst][:nexusUrl]

app_arch_file = url.split("/").last

arch_extn = app_arch_file[-3..-1]

if arch_extn == 'war' 
  repoid = node[:multitier][:app_name] || db_server[:app_name]
  tomcat_app_arch = "#{node['tomcat-all-rl']['tomcat_home']}/webapps/#{repoid}.war"


  include_recipe "tomcat-all-rl::stop"

  remote_file tomcat_app_arch do
    source url
    owner node['tomcat-all-rl']['user']
    group node['tomcat-all-rl']['group']
    mode "0644"
  end

  include_recipe "tomcat-all-rl::start"

  templ_file = File.join(node['tomcat-all-rl']['tomcat_home'], "webapps", repoid, "WEB-INF/classes/spring", "data-access.properties")

  ruby_block "sleep 10" do 
    block do
      sleep(10)
    end
  end

  include_recipe "tomcat-all-rl::stop"

  template templ_file do
    source 'data-access.properties.erb'
  end


  ruby_block "sleep 10" do 
    block do
      sleep(15)
    end
  end

  include_recipe "tomcat-all-rl::start" 

  ipaddrs = node['cloud'].nil? ? node['ipaddress'] : node['cloud']['public_ipv4']

ruby_block "get the status" do 
  block do 
    sleep(10)
    catalina_pid = %x(ps -ef | grep tomcat | grep java | awk ' { print $2 } ')
    web_inf_dir = File.join(node['tomcat-all-rl']['tomcat_home'], "webapps", repoid, "WEB-INF")

    if Dir.exists?(web_inf_dir) && !catalina_pid.empty?
      node.default["deploy_war"]["app_status"] = "Successful"
    elsif !catalina_pid.empty?
      puts "tomcat is restarted but #{repoid}.#{arch_extn} is not successfully extracted"
      node.default["deploy_war"]["app_status"] = "Failure"
    else 
      node.default["deploy_war"]["app_status"] = "Failure"
    end
      puts node["deploy_war"]["app_status"]
  end
end


ruby_block "Update App data" do
  block do
    node.default['app_data_handler']['catalystCallbackUrl'] = node[:rlcatalyst][:callbackUrl]
    node.default['app_data_handler']['app']['applicationName'] = repoid
    node.default['app_data_handler']['app']['applicationVersion'] = node[:rlcatalyst][:version]
    node.default['app_data_handler']['app']['applicationType'] = "Package"
    node.default['app_data_handler']['app']['containerId'] = "NA"
    node.default['app_data_handler']['app']['applicationInstanceName'] = repoid
    node.default['app_data_handler']['app']['applicationNodeIP'] = ipaddrs
    node.default['app_data_handler']['app']['applicationStatus'] = node["deploy_war"]["app_status"]
  end
end
include_recipe "app_data_handler"

else 

  puts "Please provide war file"
end


