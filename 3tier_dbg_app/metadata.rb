name             '3tier_dbg_app'
maintainer       'C Sraddhanand'
maintainer_email 'sraddhanand.chikine@relevancelab.com'
license          'All rights reserved'
description      'Installs/Configures multitier_war'
long_description 'Installs/Configures multitier_war'
version          '0.1.4'

depends 'tomcat-all-rl'
depends "app_data_handler", ">= 0.1.3"

attribute 'rlcatalyst/nexusUrl',
	display_name: 'Artifact URL',
	description: 'Provide url for war file to download',
	default: "https://s3-ap-southeast-2.amazonaws.com/petclinictest/petclinic_mysql.war"

attribute 'rlcatalyst/version',
  :display_name => "Application Version",
  :description => "Version of the App to be deployed",
  :default => "1.0"

attribute 'rlcatalyst/callbackUrl',
  :display_name => "Callback URL",
  :description => "Catalyst url to send node report",
  :default => "http://52.201.159.126/app/deploy"
