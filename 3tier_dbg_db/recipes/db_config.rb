# install mysql
# create user
# attributes require root_password, user, user_password, database, db_script_url, master_sql_script

apt_update 'all services' do  
    action :periodic
end

include_recipe 'build-essential::default'

# include_recipe "mysql::server"

# include_recipe "mysql::client"

mysql_service node[:mysql][:server_version] do
  port node[:mysql][:server_port]
  version node[:mysql][:server_version]
  initial_root_password node[:mysql][:initial_root_password]
  action [:create, :start]
end

package "ruby-dev"


mysql_client 'default' do
  action :create
  version node[:mysql][:client_version]
end

mysql2_chef_gem 'default' do
  gem_version '0.4.1'
  client_version node['mysql']['version']
  action :install
end

# creates dataabse with user :root
mysql_database "configure DB" do
  database_name node[:multitier][:database_name]
  connection(
    :host     => '127.0.0.1',
    :username => 'root',
    :password => node['mysql']['initial_root_password']
  )
  action :create
end


mysql_connection_info_1 = {
  :host     => '127.0.0.1',
  :username => 'root',
  :password => node['mysql']['initial_root_password']
}

# create a db user with password, privialges.
mysql_database_user node[:multitier][:database_user] do
  connection mysql_connection_info_1
  database_name node[:multitier][:database_name]
  host          '%'
  privileges    [:all]
  password   node[:multitier][:database_password] 
  action     [:create, :grant]
end




