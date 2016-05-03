name             '3tier_dbg_db'
maintainer       'C Sraddhanand'
maintainer_email 'sraddhanand.chikine@relevancelab.com'
license          'All rights reserved'
description      'Installs/Configures multitier_db'
long_description 'Installs/Configures multitier_db'
version          '0.1.4'

depends 'mysql'
depends 'database'
depends 'build-essential'
depends 'mysql2_chef_gem'
depends "app_data_handler", ">= 0.1.3"

attribute 'mysql/initial_root_password',
	display_name: 'server_root_password',
	description: 'server root password',
	type: 'string',
	default: "u8y7t6r5"

attribute 'multitier/database_name',
	display_name: "Database name",
	description: "Database Name of your application",
	default: "petclinic"

attribute 'multitier/database_user',
	display_name: "Database User",
	description: "Database User of your application",
	default: "petuser"

attribute 'multitier/database_password',
	display_name: "Database Password",
	description: "Database Password of your application",
	type: 'string',
	default: "userpet@123"

attribute "multitier/app_name",
	display_name: "Application Name",
	description: "J2EE application name",
	default: "petclinic"


attribute 'rlcatalyst/dbpkgurl',
	display_name: "DB Scripts URL",
	description: "url of database scripts as .zip or .sql",
	default: "https://s3-ap-southeast-2.amazonaws.com/petclinictest/initDB.sql"

attribute 'rlcatalyst/db_release_version',
	display_name: "Release Version",
	description: "Release Version of database package",
	default: "1.0"


attribute 'rlcatalyst/CallbackUrl',
  :display_name => "Callback URL",
  :description => "Catalyst url to send node report",
  :default => "http://52.201.159.126/app/deploy"
