#
# Cookbook Name:: jenkin
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
case node['platform']
when 'debian', 'ubuntu'
  include_recipe 'jenkin::ubuntu'
when 'redhat', 'centos', 'fedora'
  include_recipe 'jenkin::centos'
end
