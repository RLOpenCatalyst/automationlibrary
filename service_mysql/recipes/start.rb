#
# Cookbook Name:: service_mysql
# Recipe:: start
#
# Copyright 2014, Relevance Lab
#
# All rights reserved - Do Not Redistribute
#

case node['platform_family']
when 'debian'
	service "mysql" do
		action :start
	end
when 'rhel'
	service "mysqld" do
		action :start
	end
end