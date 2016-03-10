name             'deploy_war'
maintainer       'C Sraddhanand'
maintainer_email 'sraddhanand.chikine@relevancelab.com'
license          'All rights reserved'
description      'Installs/Configures deploy_war'
long_description 'Installs/Configures deploy_war'
version          '0.1.4'

depends "app_data_handler", ">= 0.1.3"
depends 'chef-client'
depends 'build-essential'

attribute 'deploy_war/source_url',
  :display_name => "Source Code URL",
  :description => "Source Code URL",
  :default => nil

attribute 'deploy_war/app_version',
  :display_name => "Application version",
  :description => "Application Release Version",
  :default => nil

attribute 'rlcatalyst/applicationNodeIP',
  :display_name => "Node Public IP",
  :description => "Current Node's public IP",
  :default => nil

attribute 'deploy_war/catalystCallbackUrl',
  :display_name => "Callback URL",
  :description => "Callback URL for application data handler",
  :default => "http://d4d.rlcatalyst.com/app/deploy"