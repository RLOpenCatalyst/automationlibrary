#
# Cookbook Name:: app_data_handler
# Recipe:: linux
#
# Copyright 2015, Relevance Lab INC
#
# All rights reserved - Do Not Redistribute
#

attrib = node['app_data_handler']
include_recipe "chef_handler"
include_recipe 'build-essential::default'
chef_gem "rest-client" do
	compile_time false if respond_to?(:compile_time)
	action :install
	
end

directory attrib['chef_cache'] do
	  owner attrib['user']
	  group attrib['group']
	  mode 00755
	  recursive true
	  action :nothing
end.run_action(:create)

# Copying Handler to specified Location
cookbook_file "#{attrib['chef_cache']}/app_data_handler.rb" do
	  source "app_data_handler.rb"
	  owner attrib['user']
	  group attrib['group']
	  mode 00755
	  action :nothing
end.run_action(:create)

puts "This is app version recieved from deployer cookbook :: #{node['app_data_handler']['app']['applicationVersion']}"

# Configuring the handler
chef_handler "AppDataHandler" do
	source lazy { "#{node['app_data_handler']['chef_cache']}/app_data_handler.rb" }
	arguments lazy { [ :cl_ws_url => node['app_data_handler']['catalystCallbackUrl'], :output_json => node['app_data_handler']['app'] ] }
	supports :exception => true, :report => true
	action :enable
end
