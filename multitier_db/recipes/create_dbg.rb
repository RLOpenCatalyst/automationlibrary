# check the data bag's existance
	# if already present, delete the databag
	# 
# required values for app server : [IP, db_name, db_user, db_password, port, app_name]
 # create dbg with above array
 

ipaddrs = node['cloud'].nil? ? node['ipaddress'] : node['cloud']['public_ipv4'] # if runlist.contains?(multitier_war) ipaddrs = 

petclinic_db = {
  'id' => node[:multitier][:app_name] + "_app",
  'db_name' => node[:multitier][:database_name],
  'db_user' => node[:multitier][:database_user],
  'db_password' => node[:multitier][:database_password],
  'ip' => ipaddrs,
  'db_port' => node[:mysql][:port],
  'mysql_root_pass' => node[:mysql][:initial_root_password],
  'app_name' => node[:multitier][:app_name]
}


#Chef::DataBag::destroy(node[:multitier][:app_name]) if Chef::DataBag.list.key?(node[:multitier][:app_name])

unless Chef::DataBag.list.key?(node[:multitier][:app_name])
  require 'chef/data_bag'
  databag = Chef::DataBag.new
  databag.name(node[:multitier][:app_name])
  databag.save
end

  databag_item = Chef::DataBagItem.new
  databag_item.data_bag(node[:multitier][:app_name])
  databag_item.raw_data = petclinic_db
  databag_item.save
 