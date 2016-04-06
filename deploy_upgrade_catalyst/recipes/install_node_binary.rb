# Cookbook Name:: deploy_upgrade_rlcatalyst
# Recipe:: install_node
#
# Copyright (C) 2015 Relevance Lab pvt ltd.
#
# All rights reserved - Do Not Redistribute
#

remote_file '/node-v4.2.2-linux-x86.tar.gz' do
	source node[:deploy_upgrade_catalyst][:repo_source]
  	action :create_if_missing
end

unless Dir.exist?("/node-v4.2.2-linux-x64")  
	execute 'extract package' do
		command	"sudo tar -C /usr/local --strip-components 1 -xzf /node-v4.2.2-linux-x86.tar.gz"
	end
end

execute 'sudo npm install npm@3.5.2 -g'
