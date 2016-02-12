#
# Cookbook Name:: app_data_handler
# Recipe:: windows
#
# Copyright 2015, Relevance Lab INC
#
# All rights reserved - Do Not Redistribute
#

attrib = node['app_data_handler']
include_recipe "chef_handler"

chef_gem "rest-client"

directory attrib['chef_cache'] do
	  owner attrib['user']
	  mode 00755
	  recursive true
	  action :nothing
end.run_action(:create)

# Copying Handler to specified Location
cookbook_file "#{attrib['chef_cache']}/app_data_handler.rb" do
	  source "app_data_handler.rb"
	  owner attrib['user']
	  mode 00755
	  action :nothing
end.run_action(:create)

# Configuring the handler
chef_handler "AppDataHandler" do
	source lazy { "#{attrib['chef_cache']}/app_data_handler.rb" }
	arguments lazy { [ :cl_ws_url => attrib['catalystCallbackUrl'], :output_json => node['app_data_handler']['app'] ] }
	supports :exception => true, :report => true
	action :enable
end