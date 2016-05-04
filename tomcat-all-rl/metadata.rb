name             'tomcat-all-rl'
maintainer       'Relevance Lab'
maintainer_email 'devops@relevancelab.com'
license          'All rights reserved'
description      'Installs/Configures tomcat-all-rl'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.2'

depends 'ark'
depends 'apt'
depends 'java'


supports 'ubuntu'
supports 'centos'
supports 'redhat'




attribute 'java/install_flavor',
  :display_name => "Java Flavour",
  :description => "Please specify Java Flavour like oracle or openjdk",
  :choice => [
    'oracle'],
  :default => "oracle"
  
attribute 'java/jdk_version',
  :display_name => "Java JDK Version",
  :description => "Please specify Java JDK Version",
  :choice => [
    '6',
    '7'],
  :default => '7'
  
attribute 'java/oracle/accept_oracle_download_terms',
  :display_name => "Oracle Download Terms",
  :description => "Please specify Oracle Download Terms",
  :choice => [
    'true',
    'false'],
  :default => 'true'

attribute 'tomcat-all-rl/user',
  :display_name => "Tomcat User",
  :description => "Please specify tomcat user",
  :default => "tomcat" 
  
attribute 'tomcat-all-rl/group',
  :display_name => "Tomcat Group",
  :description => "Please specify tomcat group",
  :default => "tomcat"
  
attribute 'tomcat-all-rl/version',
  :display_name => "Tomcat Version",
  :description => "Please specify tomcat version to install",
  :choice => [
    '7.0.53',
    '8.0.22'],
  :default => '7.0.53'
  
  attribute 'tomcat-all-rl/tomcat_home',
  :display_name => "Tomcat Home",
  :description => "Please specify tomcat home",
  :default => "/opt/tomcat7"
  
  attribute 'tomcat-all-rl/set_etc_environment',
  :display_name => "Set Tomcat Environment",
  :description => "Please specify tomcat environment variable is required or not",
   :choice => [
    'true',
    'false'],
  :default => "true"
  
    attribute 'tomcat-all-rl/shutdown_port',
  :display_name => "Tomcat Shutdown Port",
  :description => "Please specify tomcat shutdown Port",
  :default => '8005'
  
  attribute 'tomcat-all-rl/port',
  :display_name => "Tomcat Running Port",
  :description => "Please specify tomcat running Port",
  :default => '8080'
 
  
  attribute 'tomcat-all-rl/max_threads',
  :display_name => "Tomcat Max Threads",
  :description => "Please specify tomcat max_threads",
  :default => '100'
  
  attribute 'tomcat-all-rl/min_spare_threads',
  :display_name => "Tomcat Min Spare Threads",
  :description => "Please specify tomcat min_spare_threads",
  :default => '10'
 
  attribute 'tomcat-all-rl/java_opts',
  :display_name => "Tomcat Java Opts",
  :description => "Please specify tomcat java_opts",
  :default => '-d64 -server -Djava.awt.headless=true -XX:PermSize=64m -XX:MaxPermSize=256m'
  
  attribute 'tomcat-all-rl/catalina_opts',
  :display_name => "Tomcat Catalina Opts",
  :description => "Please specify tomcat catalina_opts",
  :default => ''
  
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
