#
# Cookbook Name:: deploy_jboss_ear
# Recipe:: deploy_ear
# Copyright 2016, Relevance Lab pvt ltd.
#
# All rights reserved - Do Not Redistribute
#


url = node["deploy_jboss_ear"]["nexusUrl"]
version = node["deploy_jboss_ear"]["version"]

app_det_array = url.split("/")
app_arch_file = app_det_array.last
repoid = app_arch_file.split('.')[0]
arch_extn = app_arch_file[-3..-1]
app_version = node[:deploy_jboss_ear][:app_version]
if arch_extn == 'war' then
  ear_arch_file = "#{node['jboss7']['jboss_home']}/jboss/standalone/deployments/#{repoid}.war"

elsif arch_extn == 'ear' then
  ear_arch_file = "#{node['jboss7']['jboss_home']}/jboss/standalone/deployments/#{repoid}.ear"
else
  puts "Please select either ear or war file"
end

service 'jboss' do
  action :stop
end


remote_file ear_arch_file do
  source url
  owner node['jboss7']['jboss_user']
  group node['jboss7']['jboss_user']
  mode "0644"

end

service 'jboss' do
  action :start
end

ruby_block "Update App data" do
  block do
    node.default['app_data_handler']['catalystCallbackUrl'] = node["deploy_jboss_ear"]["catalystCallbackUrl"]
    node.default['app_data_handler']['app']['applicationName'] = repoid
    node.default['app_data_handler']['app']['applicationVersion'] = app_version
    node.default['app_data_handler']['app']['applicationType'] = "Package"
    node.default['app_data_handler']['app']['containerId'] = "NA"
    node.default['app_data_handler']['app']['applicationInstanceName'] = repoid
    node.default['app_data_handler']['app']['applicationNodeIP'] = node["deploy_jboss_ear"]["applicationNodeIP"]
    node.default['app_data_handler']['app']['applicationStatus'] = 'deployed'

  end
end

include_recipe "app_data_handler"
