#
# Cookbook Name:: artifactory
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

if node[:platform] == 'ubuntu'
	include_recipe 'artifactory::ubuntu'
elsif node[:platform_family] == 'rhel'
	include_recipe 'artifactory::centos'
end