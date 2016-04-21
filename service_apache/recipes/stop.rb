#
# Cookbook Name:: service_apache
# Recipe:: stop
#
# Copyright 2014, Relevance Lab
#
# All rights reserved - Do Not Redistribute
#

case node['platform_family']
when 'debian'
	service "apache2" do
		action :stop
	end
when 'rhel'
	service "httpd" do
		action :stop
	end
end
