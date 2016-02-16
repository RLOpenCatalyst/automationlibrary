
# Cookbook Name:: deploy_upgrade_rlcatalyst
# Recipe:: install_node
#
# Copyright (C) 2015 Relevance Lab pvt ltd.
#
# All rights reserved - Do Not Redistribute
#
execute 'curl -sL https://deb.nodesource.com/setup_4.x | sudo -E bash -'
execute 'sudo apt-get update' 
package 'nodejs'

