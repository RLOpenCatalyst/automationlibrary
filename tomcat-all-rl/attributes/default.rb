default['java']['jdk_version'] ='7'
# O.S. related settings
default['tomcat-all-rl']['user'] = 'tomcat'
default['tomcat-all-rl']['group'] = 'tomcat'

# Tomcat related settings
## installation
default['tomcat-all-rl']['version'] = '7.0.53'
default['tomcat-all-rl']['tomcat_home'] = '/opt/tomcat7'
default['tomcat-all-rl']['set_etc_environment'] = true


## Tomcat user roles and credentials
default['tomcat-all-rl']['userrole'] = ['standard','manager','admin','manager-gui','manager-script']
default['tomcat-all-rl']['username'] = 'admin'
default['tomcat-all-rl']['password'] = 'admin'

## configuration
default['tomcat-all-rl']['shutdown_port'] = '8005'
default['tomcat-all-rl']['port'] = '8080'
default['tomcat-all-rl']['max_threads'] = '100'
default['tomcat-all-rl']['min_spare_threads'] = '10'
default['tomcat-all-rl']['java_opts'] = '-d64 -server -Djava.awt.headless=true -XX:PermSize=64m -XX:MaxPermSize=256m'
default['tomcat-all-rl']['catalina_opts'] = ''

# SSL Connector
default['tomcat-all-rl']['ssl_enabled'] = false
default['tomcat-all-rl']['ssl_port'] = ''
default['tomcat-all-rl']['keystore_file'] = ''
default['tomcat-all-rl']['keystore_pass'] = ''
default['tomcat-all-rl']['keystore_type'] = ''

# Lockout Realm
default['tomcat-all-rl']['lockout_realm_enabled'] = true
default['tomcat-all-rl']['lockout_realm_classname'] = 'org.apache.catalina.realm.UserDatabaseRealm'
default['tomcat-all-rl']['lockout_realm_resourcename'] = 'UserDatabase'
default['tomcat-all-rl']['lockout_realm_datasourcename'] = ''
default['tomcat-all-rl']['lockout_realm_usertable'] = ''
default['tomcat-all-rl']['lockout_realm_usernamecol'] = ''
default['tomcat-all-rl']['lockout_realm_usercredcol'] = ''
default['tomcat-all-rl']['lockout_realm_userroletable'] = ''
default['tomcat-all-rl']['lockout_realm_roleNameCol'] = ''
default['tomcat-all-rl']['lockout_realm_localdatasource'] = ''
default['tomcat-all-rl']['lockout_realm_digest'] = ''

# SSO
default['tomcat-all-rl']['SSO_enabled'] = false

# Cluster
default['tomcat-all-rl']['cluster_class'] = '' # Must be set to non-blank for Farm Deployment to work

# Farm Deployment
default['tomcat-all-rl']['farm_deploy_enabled'] = false
default['tomcat-all-rl']['farm_deploy_classname'] = ''
default['tomcat-all-rl']['farm_deploy_tempdir'] = ''
default['tomcat-all-rl']['farm_deploy_deploydir'] = ''
default['tomcat-all-rl']['farm_deploy_watchdir'] = ''
default['tomcat-all-rl']['farm_deploy_watchenabled'] = ''



# Log stash attribute for temporary storing part of config file
default['lsf_update']['log_loc'] = "/opt/tomcat7/logs/catalina.out"
default['lsf_update']['log_type'] = "tomcat"
default['lsf_update']['files'] = { "#{node['lsf_update']['log_loc']}" => "#{node['lsf_update']['log_type']}" }
