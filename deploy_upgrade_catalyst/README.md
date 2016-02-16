deploy_upgrade_catalyst Cookbook
================================
upgrade if not installs catalyst application and POST the application details to catalyst's app/deploy API.

Requirements
------------
Ubuntu 14.04
centos 7

##Cookbook dependency:
----------------------

'git', 
'mongodb3', '>=4.0.0'
'nodejs', '>=2.4.2'
'build-essential', '>=2.2.3'
'docker', '>=2.3.0' 
'chef-client', '>=3.4.0'


Attributes
----------
node["deploy_upgrade_catalyst"]["catalystCallbackUrl"] : set to "<deployed_catalyst_home_url>/app/deploy"
node["rlcatalyst"]["nexusUrl"] : Catalyst assigns the application's nexus url.
node["rlcatalyst"]["version"] : Catalyst assigns the repository's artifact version.
node["deploy_upgrade_catalyst"]["target_dir"] = "/opt"
node["deploy_upgrade_catalyst"]["download_dir"] = "/tmp"
node['rlcatalyst']['containerId'] :If docker repo is choosen for the deployment, chef-client passes the Docker container ID.
node['rlcatalyst']['containerPort'] : Container port number
node["rlcatalyst"]["dockerRepo"] = docker hub repository of the image.
node["rlcatalyst"]["applicationNodeIP"] : Pubilc IP of the node on which catalyst is running.


Usage
-----

It will be used by catalyst application when application deployment feature is used from catalyst.

