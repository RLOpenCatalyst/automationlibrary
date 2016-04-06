
default[:deploy_war][:catalystCallbackUrl] = "http://d4d.rlcatalyst.com/app/deploy"
default[:rlcatalyst][:version] =nil
default[:deploy_war][:app_version] = nil
default[:rlcatalyst][:applicationNodeIP] = nil

default[:tomcat7][:user] = "NA"
default[:tomcat7][:group] = "NA"
default[:tomcat7][:port] = "8080"
default[:deploy_war][:source_url] = nil
default[:tomcat7][:app_home] = "/opt/tomcat7/webapps"
default[:rlcatalyst][:nexusUrl] = nil