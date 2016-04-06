#
# Cookbook Name:: app_data_handler
# Attribute:: default
#
# Copyright 2015, Relevance Lab INC
#
# All rights reserved - Do Not Redistribute
#

case node['os']
	when 'linux'
		#case node['platform']
		#	when "redhat", "centos"
				default['app_data_handler']['user'] = "root"
				default['app_data_handler']['group'] = "root"
		#	when "ubuntu"
		#		default['app_data_handler']['user'] = "ubuntu"
		#		default['app_data_handler']['group'] = "ubuntu"
		#end
	default['app_data_handler']['chef_cache'] = "/var/chef/cache/handlers"

	when 'windows'
		default['app_data_handler']['user'] = "administrator"
		default['app_data_handler']['chef_cache'] = "C:/chef/cache/handlers"
end


default['app_data_handler']['catalystCallbackUrl'] = "http://d4d.rlcatalyst.com/app/deploy"
#"http://192.168.103.83:3010/deployment/addParamsAppDeploy"

default['app_data_handler']['app']['applicationName'] = nil
default['app_data_handler']['app']['applicationVersion'] = nil
default['app_data_handler']['app']['applicationInstanceName'] = nil
#default['app_data_handler']['app']['applicationNodeIP'] = node['ipaddress']
default['app_data_handler']['app']['applicationNodeIP'] = nil
default['app_data_handler']['app']['envId'] = node.chef_environment
default['app_data_handler']['app']['hostName'] = node['fqdn']
default['app_data_handler']['app']['containerId'] = nil
default['app_data_handler']['app']['applicationType'] = nil
default['app_data_handler']['app']['applicationStatus'] = nil
