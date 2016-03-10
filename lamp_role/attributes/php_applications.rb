#<> Reserved for future usage
default[:php_applications][:applications_bag] = 'php_applications'
#<> Base path where to put php applications
default[:php_applications][:apps_path] = node[:apache][:docroot_dir]
#<> Default owner for php applications
default[:php_applications][:user] = node[:apache][:user]
#<> Default group for php applications
default[:php_applications][:group] = node[:apache][:group]

#<> Database host where to create db users
default[:php_applications][:mysql_admin_credentials][:host] = 'localhost'
#<> Administrative database user for creating db users
default[:php_applications][:mysql_admin_credentials][:username] = 'root'
#<>  Administrative database password for creating db users
default[:php_applications][:mysql_admin_credentials][:password] = node[:mysql][:server_root_password]
