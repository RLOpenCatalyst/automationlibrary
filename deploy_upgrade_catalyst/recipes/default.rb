#
# Cookbook Name:: deploy_upgrade_rlcatalyst
# Recipe:: node.default
#
# Copyright 2015, mahendra.shivaswamy
#
# All rights reserved - Do Not Redistribute
#

# Assumes that nexusurl, version attributes are exposed
# GAV - GroupID, ArtifactID, Version
# Version=major.minor.buildID
# Package_name=ArtifactID-Version.zip
include_recipe "chef-client::config"

case node['os']
        when "linux"
                case node['platform']
                        when "redhat", "centos", "ubuntu"
                                include_recipe "deploy_upgrade_catalyst::linux"
                        else
                                Chef::Log.info("Sorry, There is no recipe for #{node['platform']} yet!!!")
                end
        when "windows"
                        include_recipe 'deploy_upgrade_catalyst::windows'
                else
                Chef::Log.info("Sorry, There is no recipe for #{node['os']} yet!!!")
end




