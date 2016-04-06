#
# Cookbook Name:: go
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
ark 'go' do
	url node['go']['url']
	append_env_path true
end

execute "set path" do
	command ". /etc/profile.d/go.sh"
end
