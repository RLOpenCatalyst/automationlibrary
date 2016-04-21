#
# Cookbook Name:: loadblncr
# Recipe:: default
#
# Copyright 2016, Relevance Lab Pvt LTD, Inc.
#
# All rights reserved - Do Not Redistribute
#

apt_update 'all services' do  
    action :periodic
end
include_recipe "nginx"

appservers = search(:node, 'role:"petclinic_app"')

puts appservers.class

template "/etc/nginx/nginx.conf" do
	source 'nginx.conf.erb'
	variables(
		:webserver => appservers
		)
	notifies :reload, 'service[nginx]', :immediately
end


service "nginx" do
	action :nothing
end

