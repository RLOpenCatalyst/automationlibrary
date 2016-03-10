#
# Cookbook Name:: deploy_rlcatalyst
# Recipe:: default
#
# Copyright 2015, Relevance Lab pvt ltd.
#
# All rights reserved - Do Not Redistribute
#

include_recipe "apt"
include_recipe "yum"
include_recipe "git"
include_recipe "nodejs"
include_recipe "build-essential::default"
include_recipe "nodejs::default"
include_recipe "java8::default"
include_recipe "unzip"
#include_recipe "chef-client::default"


puts "*********"
puts "#{node["platform_family"]}"
puts "*********"


### Installing gcc ###
case node["platform_family"]
when "debian"
  package 'g++'
when "rhel"
  package 'gcc-c++'
end

	if platform_family?("debian")

		execute "Update IPTables" do
			command "sudo ufw disable"
			action :run
		end  
	else
		execute "Update IPTables" do
			command "/etc/init.d/iptables stop"
			action :run
		end
	end


# puts "URL: " + node[:nodejs][:repo_url]
# puts "Source Dir: " +  node[:nodejs][:source_location]
# puts "JS File:" + node[:nodejs][:config_js]
# puts "Node version:" + node[:nodejs][:version]

execute 'Creating Directory: #{node[:nodejs][:source_location]}' do
  command "mkdir -p #{node[:nodejs][:source_location]}"
  not_if { ::File.exists?("#{node[:nodejs][:source_location]}")}
end


# puts "URI : " + node[:nodejs][:repo_url]
# app_zipname = node[:nodejs][:repo_url].split("/").last
# app_name = app_zipname.split(".")[0]
# puts "ZIPFILE NAME: " + app_zipname
# puts "FILE: " + app_name





catalyst_branch = "#{node[:catalyst][:branch]}"


git "#{Chef::Config[:file_cache_path]}/catalyst" do
  repository "https://github.com/RLOpenCatalyst/core.git"
  revision "#{catalyst_branch}"
  action :sync
end

# Changes Made by Mrigesh Priyadarshi for App Data
ruby_block "Update App data" do
	block do
		node.default['app_data_handler']['catalystCallbackUrl'] = node['nodejs_deploy']['catalystCallbackUrl']
		node.default['app_data_handler']['app']['applicationName'] = node['nodejs_deploy']['applicationName']
		version =  JSON.load(File.read("#{Chef::Config[:file_cache_path]}/catalyst/version.json"))["version"]
		node.default['app_data_handler']['app']['applicationVersion'] = version
	end
end
# ==================================

bash "catalyst_install" do
	cwd "#{Chef::Config[:file_cache_path]}/catalyst"
	code <<-EOH
	cd server
	sudo node install --seed-data
	sudo npm install -g forever	
	sudo forever start app.js
  EOH
end


# Changes Made by Mrigesh Priyadarshi for App Data
include_recipe "app_data_handler"
