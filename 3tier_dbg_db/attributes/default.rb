default[:multitier][:database_name] = "petclinic"
default[:multitier][:database_user] = "petuser"
default[:multitier][:database_password] = "userpet@123"

default[:multitier][:app_name] = "petclinic"

default[:mysql][:initial_root_password] = "u8y7t6r5"
default[:mysql][:server_version] = "5.5"
default[:mysql][:client_version] = "5.5"
default[:mysql][:port] = "3306"

default[:rlcatalyst][:dbpkgurl] = "https://s3-ap-southeast-2.amazonaws.com/petclinictest/initDB.sql"
default[:rlcatalyst][:CallbackUrl] = "http://52.201.159.126/app/deploy"
default[:rlcatalyst][:db_release_version] = "1.0"