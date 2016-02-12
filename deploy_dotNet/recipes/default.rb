#
# Cookbook Name:: deploy_iis
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe "iis"
include_recipe "git"

windows_path 'C:\\Program Files (x86)\\Git\\bin' do
  action :add
end

iis_site 'Default Web Site' do
  action [:stop, :delete]
end

directory "#{node['deploy_iis']['docroot']}\\#{node['deploy_dotNet']['AppName']}" do
  rights :read, "Everyone"
  rights :full_control, "Everyone"
  rights :write, "Everyone"
end

git "#{node['deploy_iis']['docroot']}\\#{node['deploy_dotNet']['AppName']}" do
  repository node['deploy_dotNet']['gitRepo']
  revision "master"
  action :sync
end

#Create an app pool
iis_pool 'my_app_pool' do
   action :add
 end

# create and start a new site that maps to
# the physical location C:\inetpub\wwwroot\mysite
# and uses the 'my_app_pool' application pool
iis_site node['deploy_dotNet']['AppName'] do
  application_pool "my_app_pool"
  protocol :http
  port node['deploy_dotNet']['port']
  path "#{node['deploy_iis']['docroot']}\\#{node['deploy_dotNet']['AppName']}"
  action :add
end