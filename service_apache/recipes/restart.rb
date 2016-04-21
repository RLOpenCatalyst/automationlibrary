#
# Cookbook Name:: service_apache
# Recipe:: restart
#
# Copyright 2014, Relevance Lab
#
# All rights reserved - Do Not Redistribute
#

case node['platform_family']
when 'debian'
	service "apache2" do
		action :restart
	end
when 'rhel'
	service "httpd" do
		action :restart
	end
end
