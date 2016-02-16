# Cookbook Name:: deploy_upgrade_rlcatalyst
# Recipe:: env_update
#
# Copyright (C) 2015 Relevance Lab pvt ltd.
#
# All rights reserved - Do Not Redistribute
#


    mongod_package = `which mongod`
    if mongod_package.empty? then
        include_recipe "mongodb3"
        Chef::Log.info("mongod version is installing using mongodb3 cookbook}")
    else
        mongod_version=%x(#{`which mongod`[0..-2]} --version).split("\n")[0][-5..-1]
        Chef::Log.info("MongoDB is installed")
    end
    

    node_package = `which node`
    if node_package.empty? then
        Chef::Log.info("Node is not present. Installing using nodejs cookbook")
        include_recipe 'deploy_upgrade_catalyst::install_node' 
        
    elsif %x(#{`which node`[0..-2]} --version)[1..-2] < node[:nodejs][:version] then
        `killall node | echo`
        `npm install -g n && n #{node[:nodejs][:version]}`
        node_version=%x(#{`which node`[0..-2]} --version)
        Chef::Log.info("Node has been  installed  with #{node_version}")
    else
        Chef::Log.info("Node version is up to date")
    end

    
    npm_package = `which npm`
    if npm_package.empty? then
        Chef::Log.info("npm is not present. Installing using nodejs::npm recipe")
        execute 'npm install npm@latest -g'
        
    elsif %x(#{`which npm`[0..-2]} --version)[0..-2] < node[:nodejs][:npm][:version] then
        `killall node | echo`
        `npm install -g npm && npm #{node[:nodejs][:npm][:version]}`
        npm_version=%x(#{`which npm`[0..-2]} --version)
        Chef::Log.info("npm version is #{npm_version}")
    else
        Chef::Log.info("npm version is up to date")
    end



