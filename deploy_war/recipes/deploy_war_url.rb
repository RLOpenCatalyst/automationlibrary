
#
# Cookbook Name:: deploy_war
# Recipe:: deploy_war
#
# Copyright (C) 2016 Relevance Lab pvt ltd.
#
# All rights reserved - Do Not Redistribute
#
include_recipe 'build-essential::default'


url = node[:deploy_war][:source_url]
version = node[:deploy_war][:app_version]

app_arch_file = url.split("/").last
arch_extn = app_arch_file[-3..-1]

if arch_extn == 'war' 
  repoid = app_arch_file.split('.war')[0].split('-')[0]
  tomcat_app_arch = "#{node[:tomcat7][:app_home]}/#{repoid}.war"

  service "tomcat7" do 
    action :stop
  end

  remote_file tomcat_app_arch do
    source url
    owner node[:tomcat7][:user]
    group node[:tomcat7][:group]
    mode "0644"
  end

  service "tomcat7" do 
    action :start
  end
  
  

  ruby_block "get the status" do 
    block do 
      sleep(30)
      require 'open-uri'
      require 'net/http'
      app_url = "http://#{node['rlcatalyst']['applicationNodeIP']}:#{node[:tomcat7][:port]}/#{repoid}/"
      
      url=URI(app_url)
      status_response = Net::HTTP.get_response(url)
      http_status = status_response.kind_of? Net::HTTPSuccess
      puts "application url : #{app_url}"

      if http_status
        node.default["deploy_war"]["app_status"] = "Successful"
      else
        node.default["deploy_war"]["app_status"] = "Failure"
      end
      puts node["deploy_war"]["app_status"]

    end
  end



ruby_block "Update App data" do
  block do
    node.default['app_data_handler']['catalystCallbackUrl'] = node["deploy_war"]["catalystCallbackUrl"]
    node.default['app_data_handler']['app']['applicationName'] = repoid
    node.default['app_data_handler']['app']['applicationVersion'] = node[:deploy_war][:app_version]
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
