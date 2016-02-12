name             'deploy_rlcatalyst'
maintainer       'mahendra shivaswamy'
maintainer_email 'mahendra.shivaswamy@relevancelab.com'
license          'All rights reserved'
description      'Installs/Configures deploy_rlcatalyst'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.3'


depends 'nodejs'
depends 'build-essential'
depends 'git'
depends 'java8'
depends 'mongodb3'
depends 'nodejs'
depends 'unzip'
depends 'apt'
depends 'yum'
depends 'chef-client'

# Changes Made by Mrigesh Priyadarshi
depends "app_data_handler", ">= 0.1.3"


   attribute 'catalyst/branch',
  :display_name => "Catalyst Code Branch",
  :description => "Please specify Catalyst Code Branch",
  :default => 'dev_catalyst'

   attribute 'instances/Mongo',
  :display_name => "Mongodb Host",
  :description => "Please specify Mongodb Host",
  :default => 'localhost'

   attribute 'nodejs/version',
  :display_name => "Nodejs Version",
  :description => "Please specify Nodejs version",
  :default => '4.2.2'

  attribute 'nodejs/npm/version',
  :display_name => "npm version",
  :description => "Specify the npm version",
  :default => "3.5.2"