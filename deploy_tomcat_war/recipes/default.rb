#
# Cookbook Name:: deploy_tomcat_war
# Recipe:: default
#
# Copyright (C) 2016 Relevance Lab pvt ltd.
#
# All rights reserved - Do Not Redistribute
#

# instal the tomcat
include_recipe "tomcat-all-rl::default"

# install the build-essetials
include_recipe 'build-essential::default'

puts "printing url :: #{node["rlcatalyst"]["nexusUrl"]}"

url = node["rlcatalyst"]["nexusUrl"]
version = node["rlcatalyst"]["version"]

if url.nil? then
	puts "Nothing to do, url and version are not specified"
	Chef::Log.info("Nothing to do, url and version are not specified")
else
	include_recipe "deploy_tomcat_war::deploy_war"
end

