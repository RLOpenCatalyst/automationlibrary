#
# Cookbook Name:: docker_install
# Recipe:: default
#
# Copyright (C) 2016 YOUR_NAME
#
# All rights reserved - Do Not Redistribute
#

docker_service 'default' do
  action [:create, :start]
end
