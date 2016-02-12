name             'docker_pull_rl'
maintainer       'C Sraddhanand'
maintainer_email 'Sraddhanand.chikine@relevancelab.com'
license          'All rights reserved'
description      'Installs/Configures docker_pull_rl'
long_description 'Installs/Configures docker_pull_rl'
version          '0.1.2'

depends 'docker'

attribute 'docker_pull_rl/image',
  :display_name => "Docker Image",
  :description => "mention in repo/image format",
  :default => nil

attribute 'docker_pull_rl/user_id',
	:display_name => 'User ID',
	:description => 'Docker Hub Login ID',
	:default => nil

attribute 'docker_pull_rl/password',
	:display_name => 'Password',
	:description => 'Login password for above User ID',
	:default => nil

attribute 'docker_pull_rl/email',
	:display_name => 'email',
	:description => 'Registerd email ID of Docker Hub',
	:default => nil


