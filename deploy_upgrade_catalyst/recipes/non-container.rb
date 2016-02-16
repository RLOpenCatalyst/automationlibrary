# Cookbook Name:: deploy_upgrade_rlcatalyst
# Recipe:: non-container
#
# Copyright (C) 2015 Relevance Lab pvt ltd.
#
# All rights reserved - Do Not Redistribute
#

url = node["rlcatalyst"]["nexusUrl"]
repo = url.split("/").values_at(6)
repoid = repo[0]
app_name = url.split("/").last.split("-").first  #D4d
version = node["rlcatalyst"]["version"]
package_name = url.split("/").last                    #D4D-2.1.10.zip
package = "#{app_name}" + "-" + "#{version}" #D4D-2.1.10

# Deploy app if doesnot exists alreday
include_recipe "deploy_upgrade_catalyst::env_update"

if Dir.exists?("#{Chef::Config[:file_cache_path]}/#{repoid}/#{package}")
 include_recipe "deploy_upgrade_catalyst::no_deploy"
elsif
 include_recipe "deploy_upgrade_catalyst::pre_deploy"
end
