name             'deploy_jboss_ear'
maintainer       'C Sraddhanand'
maintainer_email 'sraddhanand.chikine@relevancelab.com'
license          'All rights reserved'
description      'Installs/Configures deploy_jboss_ear'
long_description 'Installs/Configures deploy_jboss_ear'
version          '0.1.1'

depends 'jboss7_rl'
depends "app_data_handler", ">= 0.1.3"
depends 'build-essential'

attribute 'deploy_jboss_ear/nexusUrl',
  :display_name => "Nexus Repo URL",
  :description => "Mention Nexus url of the repo",
  :default => nil

attribute 'deploy_jboss_ear/catalystCallbackUrl',
  :display_name => "Call Back Url",
  :description => "call back url  for data handler",
  :default => "http://d4d.rlcatalyst.com/app/deploy"


attribute 'deploy_jboss_ear/applicationNodeIP',
  :display_name => "applicationNodeIP",
  :description => "Accepting ip address of instance",
  :default => "NA"

attribute 'deploy_jboss_ear/app_version',
  :display_name => "Application Version",
  :description => "Source code version",
  :default => "NA"

