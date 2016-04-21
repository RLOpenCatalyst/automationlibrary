#
# Cookbook Name:: service_mysql
# Recipe:: restart
#
# Copyright 2014, Relevance Lab
#
# All rights reserved - Do Not Redistribute
#

case node['platform_family']
when 'debian'
	service "mysql" do
		action :restart
	end
when 'rhel'
	service "mysqld" do
		action :restart
	end
end