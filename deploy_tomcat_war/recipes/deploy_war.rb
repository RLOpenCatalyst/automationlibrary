
catalystCallbackUrl = node["deploy_tomcat_war"]["catalystCallbackUrl"]
url = node["rlcatalyst"]["nexusUrl"]
version = node["rlcatalyst"]["version"]

app_det_array = url.split("repositories/")[1].split("/")

repoid = app_det_array[0]

app_arch_file = app_det_array.last


tomcat_app_arch = "#{node['tomcat-all-rl']['tomcat_home']}/webapps/#{repoid}.war"

include_recipe "tomcat-all-rl::stop"

remote_file tomcat_app_arch do
  source url
  owner node['tomcat-all-rl']['user']
  group node['tomcat-all-rl']['group']
  mode "0644"

end

puts url
puts version
puts tomcat_app_arch
puts node[:rlcatalyst][:applicationNodeIP]

include_recipe "tomcat-all-rl::start"


ruby_block "get the status" do 
  block do 
    sleep(15)
    require 'open-uri'
    require 'net/http'
    app_url = "http://#{node['rlcatalyst']['applicationNodeIP']}:#{node['tomcat-all-rl']['port']}/#{repoid}/"
    
    url=URI(app_url)
    status_response = Net::HTTP.get_response(url)
    http_status = status_response.kind_of? Net::HTTPSuccess
    puts "application url : #{app_url}"

    if http_status
      node.default["deploy_tomcat_war"]["app_status"] = "Successful"
    else
      node.default["deploy_tomcat_war"]["app_status"] = "Failure"
    end
    puts node["deploy_tomcat_war"]["app_status"]

  end
end

ruby_block "Update App data" do
  block do
    node.default['app_data_handler']['catalystCallbackUrl'] = catalystCallbackUrl
    node.default['app_data_handler']['app']['applicationName'] = repoid
    node.default['app_data_handler']['app']['applicationVersion'] = node["rlcatalyst"]["version"]
    node.default['app_data_handler']['app']['applicationType'] = "Package"
    node.default['app_data_handler']['app']['containerId'] = "NA"
    node.default['app_data_handler']['app']['applicationNodeIP'] = node["rlcatalyst"]["applicationNodeIP"]
    node.default['app_data_handler']['app']['applicationInstanceName'] = repoid
    node.default['app_data_handler']['app']['applicationStatus'] = node["deploy_tomcat_war"]["app_status"]
  end
end

include_recipe "app_data_handler"
