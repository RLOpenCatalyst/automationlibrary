#
# Cookbook Name:: deploy_upgrade_rlcatalyst
# Recipe:: default
#
# Copyright 2015, mahendra.shivaswamy
#
# All rights reserved - Do Not Redistribute
#

# Assumes that nexusurl, version, containerID attributes are exposed
# GAV - GroupID, ArtifactID, Version
# Version=major.minor.buildID
# Package_name=ArtifactID-Version.zip

node.default['build-essential']['compile_time'] = true
include_recipe 'build-essential::default'

puts "printing url :: #{node["rlcatalyst"]["nexusUrl"]}"

url = node["rlcatalyst"]["nexusUrl"]
version = node["rlcatalyst"]["version"]
containerId = node["rlcatalyst"]["containerId"]
dockerRepo = node["rlcatalyst"]["dockerRepo"]

if url.nil? && version.nil? then
puts "Nothing to do, url and version are not specified"
Chef::Log.info("Nothing to do, url and version are not specified")
elsif "#{containerId}" != "NA" && "#{dockerRepo}" != "NA"
include_recipe "deploy_upgrade_catalyst::container"
elsif "#{containerId}" == "NA"
include_recipe "deploy_upgrade_catalyst::non-container"
end

Chef::Log.info("Chef-client finished its run, please check logs in catalyst application section")


