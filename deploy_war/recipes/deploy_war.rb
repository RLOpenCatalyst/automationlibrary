
#
# Cookbook Name:: deploy_war
# Recipe:: deploy_war
#
# Copyright (C) 2016 Relevance Lab pvt ltd.
#
# All rights reserved - Do Not Redistribute
#
include_recipe 'build-essential::default'
include_recipe 'zip'

url = node[:rlcatalyst][:nexusUrl]
version = node[:rlcatalyst][:version]

#app_det_array = url.split("/")
app_arch_file = url.split("/").last
arch_extn = app_arch_file[-3..-1]

if arch_extn == 'war' 
  repoid = app_arch_file.split('.war')[0].split('-')[0]
  tomcat_app_arch = "#{node[:tomcat7][:app_home]}/#{repoid}.war"

include_recipe 'tomcat-all-rl::stop'  

directory "/opt/archive/" do
  action :create
end

if Dir.exist?(File.join(node[:tomcat7][:app_home],repoid))
  bkp_name = repoid + "_" + DateTime.now.strftime("%Y%m%d_%H%M%S") + ".zip" 
  puts "bkp_name: #{bkp_name}"
  execute "zip -r /opt/archive/#{bkp_name} #{repoid}" do
    cwd lazy {node[:tomcat7][:app_home]}
  end

  directory repoid do 
    path "#{lazy {node[:tomcat7][:app_home]} }/repoid"
    action :delete
  end
end 

  remote_file tomcat_app_arch do
    source url
    owner node[:tomcat7][:user]
    group node[:tomcat7][:group]
    mode "0644"
    action :create
  end

include_recipe 'tomcat-all-rl::start'  
  

  ruby_block "get the status" do 
    block do 
    sleep(30)
    catalina_pid = %x(ps -ef | grep tomcat | grep java | awk ' { print $2 } ')
    puts "Tomcat is running at PID: #{catalina_pid}"
    if Dir.exists?("#{node[:tomcat7][:app_home]}/#{repoid}/WEB-INF") && !catalina_pid.empty?
      node.default["deploy_war"]["app_status"] = "Successful"
    elsif !catalina_pid.empty?
      puts "tomcat is restarted but #{repoid}.#{arch_extn} is successfully extracted"
      node.default["deploy_war"]["app_status"] = "Failure"
    else 
      node.default["deploy_war"]["app_status"] = "Failure"
    end
      puts node["deploy_war"]["app_status"]
  end
end



ruby_block "Update App data" do
  block do
    node.default['app_data_handler']['catalystCallbackUrl'] = node[:deploy_war][:catalystCallbackUrl]
    node.default['app_data_handler']['app']['applicationName'] = repoid
    node.default['app_data_handler']['app']['applicationVersion'] = version
    node.default['app_data_handler']['app']['applicationType'] = "Package"
    node.default['app_data_handler']['app']['containerId'] = "NA"
    node.default['app_data_handler']['app']['applicationNodeIP'] = node["rlcatalyst"]["applicationNodeIP"]
    node.default['app_data_handler']['app']['applicationInstanceName'] = repoid
    node.default['app_data_handler']['app']['applicationStatus'] = node["deploy_war"]["app_status"]
  end
end

  include_recipe "app_data_handler"
else
 puts "Please provide the url of war file"

end
