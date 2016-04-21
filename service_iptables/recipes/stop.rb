#
# Cookbook Name:: service_apache
# Recipe:: stop
#
# Copyright 2014, Relevance Lab
#
# All rights reserved - Do Not Redistribute
#

case node['platform_family']
when 'rhel'
	service "iptables" do
		action :stop
	end
end
