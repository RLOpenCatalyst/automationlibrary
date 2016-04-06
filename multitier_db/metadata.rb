name             'multitier_db'
maintainer       'YOUR_NAME'
maintainer_email 'YOUR_EMAIL'
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
	default: nil

attribute 'multitier/database_name',
	display_name: "Database name",
	description: "Database Name of your application",
	default: nil

attribute 'multitier/database_user',
	display_name: "Database User",
	description: "Database User of your application",
	default: nil

attribute 'multitier/database_password',
	display_name: "Database Password",
	description: "Database Password of your application",
	type: 'string',
	default: nil

attribute "multitier/app_name",
	display_name: "Application Name",
	description: "J2EE application name",
	default: nil


attribute 'rlcatalyst/dbpkgurl',
	display_name: "DB Scripts URL",
	description: "url of database scripts as .zip or .sql",
	default: nil

attribute 'rlcatalyst/db_release_version',
	display_name: "Release Version",
	description: "Release Version of database package",
	default: nil


attribute 'rlcatalyst/CallbackUrl',
  :display_name => "Callback URL",
  :description => "Catalyst url to send node report",
  :default => nil
