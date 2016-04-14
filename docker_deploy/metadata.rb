name             'docker_deploy'
maintainer       'C Sraddhanan'
maintainer_email 'sraddhanan.chikine@relevancelab.com'
license          'All rights reserved'
description      'Installs/Configures docker_deploy'
long_description 'Installs/Configures docker_deploy'
version          '0.1.3'

depends 'docker', "2.4.7"
depends "app_data_handler", ">= 0.1.3"
depends 'build-essential'

attribute 'rlcatalyst/dockerImage',
  :display_name => "Docker Image",
  :description => "mention in repo/image format",
  :default => nil

attribute 'rlcatalyst/imageTag',
  :display_name => "Docker Image Tag",
  :description => "mention in docker image tag",
  :default => nil

attribute 'rlcatalyst/dockerUser',
	:display_name => 'User ID',
	:description => 'Docker Hub Login ID',
	:default => nil

attribute 'rlcatalyst/dockerPassword',
	:display_name => 'Password',
	:description => 'Login password for above User ID',
	:default => nil

attribute 'rlcatalyst/dockerEmailId',
	:display_name => 'email',
	:description => 'Registerd email ID of Docker Hub',
	:default => nil

attribute 'rlcatalyst/containerPort',
	:display_name => 'Docker Port',
	:description => 'Application Port number inside container',
	:default => nil

attribute 'rlcatalyst/hostPort',
	:display_name => 'Host Port Number',
	:description => 'Map container port to Host Port Number',
	:default => nil

attribute 'rlcatalyst/containerId',
	:display_name => 'Container Name',
	:description => 'Container Name',
	:default => nil


attribute 'rlcatalyst/applicationNodeIP',
	display_name: "Application IP",
	description: "Accepting ip address of instance",
	default: nil 


attribute 'rlcatalyst/ContainerVolumes',
	display_name: "Container Volumes",
	description: "Bind volumes container with host",
	default: nil 

attribute 'rlcatalyst/upgrade',
    display_nam: "Upgrade",
    description: "Upgrade the application",
    type:  "boolean",
    choice: [true,false],
    default: false



