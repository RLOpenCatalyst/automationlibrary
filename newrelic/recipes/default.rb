#
# Cookbook Name:: newrelic
# Recipe:: default
#
# Copyright 2012-2015, Escape Studios
#

include_recipe 'newrelic::java_agent'
directory "/usr/local/tomcat-7.0.53/newrelic" do 
    action :create
end

include_recipe 'tomcat-all-rl::stop'  


execute "moving newrelic jar" do
    command "cp -f /opt/tomcat7/newrelic.jar /usr/local/tomcat-7.0.53/newrelic/newrelic.jar"
end

execute "moving newrelic yml" do
    command "cp -f /opt/tomcat7/newrelic.yml /usr/local/tomcat-7.0.53/newrelic/newrelic.yml"
end

  ruby_block "waiting 30 sec" do 
    block do 
        sleep(30)
    end
end

include_recipe 'tomcat-all-rl::start'  