#
# Cookbook Name:: service_mysql
# Recipe:: stop
#
# Copyright 2014, Relevance Lab
#
# All rights reserved - Do Not Redistribute
#

case node['platform_family']
when 'debian'
	service "mysql" do
		action :stop
	end
when 'rhel'
	service "mysqld" do
		action :stop
	end
end