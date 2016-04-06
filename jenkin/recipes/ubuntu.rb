#
# Cookbook Name:: jenkin
# Recipe:: ubuntu
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
execute 'update' do
  command "apt-get update"
  action :run
end

package node['jenkin']['java']['packagename']

execute 'Add-jenkin-key' do
  command "wget -q -O - #{node['jenkin']['apt_repokey']} | sudo apt-key add -"
  action :run
end

template "#{node['jenkin']['apt_get_repoloc']}/#{node['jenkin']['apt_repofile']}" do
  source "#{node['jenkin']['apt_repofile']}.erb"
  owner node['jenkin']['user']
  group node['jenkin']['group']
  mode 0644
end

execute 'update' do
  command "apt-get update"
  action :run
end

package node['jenkin']['install']

service node['jenkin']['install'] do
   supports :status => true, :restart => true, :reload => true
   action [ :enable, :start ]
end
