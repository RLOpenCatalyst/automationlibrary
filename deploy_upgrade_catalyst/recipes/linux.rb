# Cookbook Name:: deploy_upgrade_rlcatalyst
# Recipe:: linux
#
# Copyright (C) 2015 Relevance Lab pvt ltd.
#
# All rights reserved - Do Not Redistribute
#

node.default['build-essential']['compile_time'] = true
include_recipe 'build-essential::default'

url = node[:rlcatalyst][:nexusUrl] || node[:deploy_upgrade_catalyst][:app_source_url] 
version = node[:rlcatalyst][:version] || node[:deploy_upgrade_catalyst][:app_version] 
puts url
containerId = node[:rlcatalyst][:containerId]
dockerRepo = node[:rlcatalyst][:dockerRepo]

if url.nil? && version.nil? 
	puts "Nothing to do, url and version are not specified"
	Chef::Log.info("Nothing to do, url and version are not specified")
elsif !containerId.nil? && !dockerRepo.nil?
	include_recipe "deploy_upgrade_catalyst::container"
elsif containerId.nil?
	include_recipe "deploy_upgrade_catalyst::deploy_catalyst"
end

Chef::Log.info("Chef-client finished its run, please check logs in catalyst application section")


