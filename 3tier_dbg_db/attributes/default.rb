default[:multitier][:database_name] = "petclinic"
default[:multitier][:database_user] = "petuser"
default[:multitier][:database_password] = nil

default[:multitier][:app_name] = "petclinic"

default[:mysql][:initial_root_password] = nil
default[:mysql][:server_version] = "5.5"
default[:mysql][:client_version] = "5.5"
default[:mysql][:port] = "3306"

default[:rlcatalyst][:dbpkgurl] = nil
default[:rlcatalyst][:CallbackUrl] = "http://d4d.rlcatalyst.com/app/deploy"
default[:rlcatalyst][:db_release_version] = nil