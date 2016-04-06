name             'deploy_upgrade_catalyst'
maintainer       'mahendra.shivaswamy'
maintainer_email 'mahendra.shivaswamy@outlook.com'
license          'All rights reserved'
description      'Installs/Configures nexus_deploy_rlcatalyst'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.2.0'

depends 'git'
depends 'mongodb3'
#depends 'nodejs', 
depends 'build-essential'
depends 'docker'
depends 'chef-client'

# Changes Made by Gobinda Das
depends "app_data_handler", ">= 0.1.3"

attribute 'deploy_upgrade_catalyst/app_source_url',
  :display_name => "Source Url",
  :description => "Artifact Url",
  :default => nil

attribute 'deploy_upgrade_catalyst/app_version',
  :display_name => "Version",
  :description => "Version of the App to be deployed",
  :default => nil


attribute 'rlcatalyst/nexusUrl',
  :display_name => "Nexus Repo Url",
  :description => "Nexus Repo Url",
  :default => nil

attribute 'rlcatalyst/version',
  :display_name => "Version",
  :description => "Version of the App to be deployed",
  :default => nil


attribute 'rlcatalyst/containerId',
  :display_name => "Container Id",
  :description => "Container Id of already running container",
  :default => nil

attribute 'rlcatalyst/containerPort',
  :display_name => "Container Port",
  :description => "Container port to deploy application newly",
  :default => nil

attribute 'rlcatalyst/dockerRepo',
  :display_name => "Container Repository",
  :description => "Docker repository to deploy new app in a container",
  :default => nil

attribute 'rlcatalyst/upgrade',
  :display_name => "Container Upgrade",
  :description => "Docker repository to deploy new app in a existing container",
  :default => nil

attribute 'deploy_upgrade_catalyst/catalystCallbackUrl',
  :display_name => "Callback URL for app data ",
  :description => "Catalyst's call back url for app deploy data",
  :default => "http://d4d.rlcatalyst.com/app/deploy"


attribute 'rlcatalyst/applicationNodeIP',
  :display_name => "applicationNodeIP",
  :description => "Accepting ip address of instance",
  :default => nil
