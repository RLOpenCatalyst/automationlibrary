#
# Cookbook Name:: nodejs_deploy
# Recipe:: default
#
# Copyright 2015, Relevance Lab pvt ltd.
#
# All rights reserved - Do Not Redistribute
#

default[:nodejs][:repo_url]= nil
default[:nodejs][:source_location]="/home/user/catalyst"
default[:nodejs][:appserver]="server"
default[:nodejs][:config_js]="app.js"
default[:nodejs][:version] = '4.2.2'
default[:catalyst][:branch]="master"
default[:instances][:Mongo]="localhost"

default[:nodejs][:npm][:version] = "3.5.2"
default[:nodejs][:npm][:install_method] = 'source'






default['nodejs_deploy']['catalystCallbackUrl'] = "http://d4d.rlcatalyst.com/app/deploy"
#"http://supercatalyst.relevancelab.com/app/deploy"
default['nodejs_deploy']['applicationName'] = "Catalyst"
