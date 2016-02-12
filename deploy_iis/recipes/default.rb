# Cookbook Name:: deploy_iis
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

#include_recipe "iis_test"


iis_site 'Default Web Site' do
  action [:stop, :delete]
end


directory "#{node['deploy_iis']['docroot']}\\demo" do
  rights :read, "Everyone"
  rights :full_control, "Everyone"
  rights :write, "Everyone"
  action :create
end

puts "URI : " + node[:deploy_iis][:applink]
app_zipname = node[:deploy_iis][:applink].split("/").last
app_name = app_zipname.split(".")[0]
puts "ZIPFILE NAME: " + app_zipname
puts "FILE: " + app_name


windows_zipfile "#{node['deploy_iis']['docroot']}\\demo" do
  source node['deploy_iis']['applink']
  action :unzip
  not_if {::File.exists?("C:\chef\cache\\#{app_zipname}.zip")}
end

#Create an app pool

iis_pool 'my_app_pool' do
  runtime_version "4.0"
#  pipeline_mode :Integrated
  action [:add, :start]
 end

# create and start a new site that maps to
# the physical location C:\inetpub\wwwroot\mysite
# and uses the 'my_app_pool' application pool

iis_site 'demo' do
  application_pool "my_app_pool"
  protocol :http
  port 80
  path "#{node['deploy_iis']['docroot']}/demo"
  action [:add, :start]
end
