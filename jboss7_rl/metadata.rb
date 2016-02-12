name             'jboss7_rl'
maintainer       'Relevance Lab'
maintainer_email 'sraddhanand.chikine@relevancelab.com'
license          'All rights reserved'
description      'Installs/Configures jboss7_rl'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

depends 'jboss7'

attribute 'jboss7/jboss_home',
  :display_name => "Jboss7 Home",
  :description => "Please specify Jboss7 home",
  :default => "/opt/"

attribute 'jboss7/jboss_user',
  :display_name => "Jboss7 User",
  :description => "Please specify Jboss7 default User",
  :default => "web"  

attribute 'jboss7/dl_url',
  :display_name => "Jboss7 Download Url",
  :description => "Please specify Jboss7 Download url",
  :default => "http://download.jboss.org/jbossas/7.1/jboss-as-7.1.1.Final/jboss-as-7.1.1.Final.tar.gz"    


attribute 'jboss7/jvm_min_mem',
  :display_name => "JVM minimum memory",
  :description => "Please specify minimum memory for JVM",
  :default => "512m"    

attribute 'jboss7/jvm_max_mem',
  :display_name => "JVM Maximum memory",
  :description => "Please specify maximum memory for JVM",
  :default => "1024m"    

attribute 'jboss7/jvm_extra_ops',
  :display_name => "JVM extra Ops",
  :description => "Please specify JVM extra Ops",
  :default => ""    

attribute 'jboss7/ajp_port',
  :display_name => "Jboss7 ajp Port",
  :description => "Please specify AJP port",
  :default => "8009"    

attribute 'jboss7/http_port',
  :display_name => "Jboss7 Http Port",
  :description => "Please specify http port",
  :default => "8080"    


attribute 'jboss7/https_port',
  :display_name => "Jboss7 Https Port",
  :description => "Please specify https port",
  :default => "8443"    


attribute 'jboss7/public_bind_addr',
  :display_name => "Jboss7 Public Bind Address",
  :description => "Please specify Public Bind Address",
  :default => "0.0.0.0"

attribute 'jboss7/mgmt_bind_addr',
  :display_name => "Jboss7 management Bind Address",
  :description => "Please specify management Bind Address",
  :default => "0.0.0.0"

attribute 'jboss7/unsecure_bind_addr',
  :display_name => "Jboss7 Unsecure Bind Address",
  :description => "Please specify Unsecure Bind Address",
  :default => "0.0.0.0"

attribute 'jboss7/admin_user',
  :display_name => "Jboss7 Admin User",
  :description => "Please specify Admin User",
  :default => "Administrator"

attribute 'jboss7/admin_pass',
  :display_name => "Jboss7 Admin Password",
  :description => "Please specify Admin Password",
  :default => "12367834kdfsugsdcss83eqw2341"    