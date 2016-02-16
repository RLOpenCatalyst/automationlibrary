#
# Cookbook Name:: deploy_jboss_ear
# Recipe:: default
# Copyright 2015, Relevance Lab pvt ltd.
#
# All rights reserved - Do Not Redistribute
#

# instal the tomcat
include_recipe "jboss7_rl::default"

# install the build-essetials
include_recipe 'build-essential::default'

url = node["deploy_jboss_ear"]["nexusUrl"]
version = node["deploy_jboss_ear"]["version"]

if url.nil? then
	puts "Nothing to do, url and version are not specified"
	Chef::Log.info("Nothing to do, url and version are not specified")
else
	include_recipe "deploy_jboss_ear::deploy_ear"
end
# package "unzip"
# package "zip"
