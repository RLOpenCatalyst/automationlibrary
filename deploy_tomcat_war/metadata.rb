name             'deploy_tomcat_war'
maintainer       'C Sraddhanand'
maintainer_email 'sraddhanand.chikine@relevancelab.com'
license          'All rights reserved'
description      'Installs/Configures deploy_tomcat_war'
long_description 'Installs/Configures deploy_tomcat_war'
version          '0.1.8'

depends 'tomcat-all-rl'
depends "app_data_handler", ">= 0.1.3"
depends 'build-essential'
depends 'chef-client'

attribute 'rlcatalyst/nexusUrl',
  :display_name => "Nexus Repo Url",
  :description => "Nexus Repo Url",
  :default => "url"

attribute 'rlcatalyst/version',
  :display_name => "Version",
  :description => "Version of the App to be deployed",
  :default => "version"

attribute 'rlcatalyst/applicationNodeIP',
  :display_name => "applicationNodeIP",
  :description => "Accepting ip address of instance",
  :default => "NA"

attribute 'deploy_tomcat_war/catalystCallbackUrl',
	:display_name => 'Call Back URL',
	:description => 'Mention callback url for data handler',
	:default => "http://d4d.rlcatalyst.com/app/deploy"
