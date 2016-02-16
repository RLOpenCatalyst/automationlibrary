# Cookbook Name:: deploy_upgrade_rlcatalyst
# Recipe:: pre_deploy
#
# Copyright (C) 2015 Relevance Lab pvt ltd.
#
# All rights reserved - Do Not Redistribute
#

catalystCallbackUrl = node["deploy_upgrade_catalyst"]["catalystCallbackUrl"]
url = node["rlcatalyst"]["nexusUrl"]
version = node["rlcatalyst"]["version"]
applicationNodeIP = node["rlcatalyst"]["applicationNodeIP"]
package_type = url.split(".").last               #zip
app_name = url.split("/").last.split("-").first  #D4d
repo = url.split("/").values_at(6)
package_name = url.split("/").last                    #D4D-2.1.10.zip
version = url.split("/").last.split("-").last.split(".").first(3).join(".") #2.1.10
package = "#{app_name}" + "-" + "#{version}" #D4D-2.1.10
download_dir = node["deploy_upgrade_catalyst"]["download_dir"]
repoid = url.split("repositories/")[1].split("/")[0]

puts "url :: #{url}"
puts "version :: #{version}"
puts "package_type :: #{package_type}"
puts "app_name :: #{app_name}"
puts "package_name :: #{package_name}"
puts "catalystCallbackUrl :: #{catalystCallbackUrl}"
puts "repo :: #{repoid}"
puts "applicationNodeIP :: #{applicationNodeIP}"

package "unzip"

package "zip"

directory "#{Chef::Config[:file_cache_path]}/#{repoid}" do
action :create
not_if {Dir.exists?("#{Chef::Config[:file_cache_path]}/#{repoid}")}
end

directory "#{Chef::Config[:file_cache_path]}/#{repoid}/#{package}" do
action :create
not_if {Dir.exists?("#{Chef::Config[:file_cache_path]}/#{repoid}/#{package}")}
end

include_recipe "deploy_upgrade_catalyst::post_deploy"
