#
# Cookbook Name:: app_data_handler
# Recipe:: default
#
# Copyright 2015, Relevance Lab INC
#
# All rights reserved - Do Not Redistribute
#

case node['os']
	when "linux"
		case node['platform']
			when "redhat", "centos", "ubuntu"
				include_recipe "app_data_handler::linux"
			else
				Chef::Log.info("Sorry, There is no recipe for #{node['platform']} yet!!!")
		end
	when "windows"
         		include_recipe 'app_data_handler::windows'
         	else
                Chef::Log.info("Sorry, There is no recipe for #{node['os']} yet!!!")
end