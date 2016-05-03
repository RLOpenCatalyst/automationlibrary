#
# Cookbook Name:: multitier_db
# Recipe:: default
#
# Copyright (C) 2016 YOUR_NAME
#
# All rights reserved - Do Not Redistribute
#

# check for the attributes
# if not found check for the data bag item for credentials
# 

puts node[:mysql][:server_root_password]

#execute "apt-get update"
apt_update 'all services' do
    action :update
end

# if data bag is already present and ip is same as current node, dont create databag, if IP is not same delete and create databag
#This is done. if password is passed as attribute to current cookbook, mysql root would be created with the given password, else random password
# add recipe to create a database user. Get the details from attributes in metadata.rb.

# choise of databases.
# install mysql only if it is not installed already.
# let the DBA choose this cookbook to upgrade db components.



db_server = search(:petclinic, "id:petclinic_app").first




include_recipe "mysql::server"

include_recipe "mysql::client"


directory "/opt/db_files"

template "/opt/db_files/configure.sql" do 
	source 'configure.sql.erb'
end

cookbook_file "/opt/db_files/initDB.sql" do
	source "initDB.sql"
end

ipaddrs = node['cloud']['public_ipv4'] || node['ipaddress']  # if runlist.contains?(multitier_war) ipaddrs = 

petclinic_db = {
  'id' => 'petclinic_app',
  'db_name' => node[:multitier][:database_name],
  'full_name' => 'petclinic database',
  'ip' => ipaddrs,
  'db_port' => node[:mysql][:port],
  'mysql_root_pass' => node[:mysql][:server_root_password],
  'app_name' => node[:multitier][:database_name]
}

unless Chef::DataBag.list.key?('petclinic')
  require 'chef/data_bag'
  databag = Chef::DataBag.new
  databag.name("petclinic")
  databag.save
end

  databag_item = Chef::DataBagItem.new
  databag_item.data_bag('petclinic')
  databag_item.raw_data = petclinic_db
  databag_item.save
#end



bash "db create" do 
  cwd "/opt/db_files"
  code <<-EOH
    mysql --user=root --password=#{node['mysql']['server_root_password']} < configure.sql
    EOH
end 

bash "db configure" do 
  cwd "/opt/db_files"
  code <<-EOH
    mysql --user=root --password=#{node[:mysql][:server_root_password]} < initDB.sql
  EOH
end 

