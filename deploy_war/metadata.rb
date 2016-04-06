name             'deploy_war'
maintainer       'Sraddhanand'
maintainer_email 'sraddhanand.chikine@relevancelab.com'
license          'All rights reserved'
description      'Installs/Configures deploy_war'
long_description 'Installs/Configures deploy_war'
version          '0.1.8'

depends "app_data_handler", ">= 0.1.3"
depends 'chef-client', '3.4.0'
depends 'build-essential', '2.2.3'
depends 'tomcat-all-rl', '>=0.1.0'
depends 'zip', '1.1.0'

attribute 'rlcatalyst/nexusUrl',
  :display_name => "Source Code URL",
  :description => "Source Code URL",
  :default => nil

attribute 'rlcatalyst/version',
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