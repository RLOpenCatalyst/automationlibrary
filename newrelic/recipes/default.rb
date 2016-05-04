#
# Cookbook Name:: newrelic
# Recipe:: default
#
# Copyright 2012-2015, Escape Studios
#

include_recipe 'newrelic::java_agent'
directory "/usr/local/tomcat-7.0.53/newrelic" do 
    action :create
    owner node['newrelic']['java_agent']['app_user']
    group node['newrelic']['java_agent']['app_group']
end

execute "stop tomcat" do 
    command "service tomcat7 stop"
    #ignore_errors true
    ignore_failure true
end

execute "moving newrelic jar" do
    command "cp -f /opt/tomcat7/newrelic.jar /usr/local/tomcat-7.0.53/newrelic/newrelic.jar"
    group node['newrelic']['java_agent']['app_group']
    user node['newrelic']['java_agent']['app_user']
end

execute "moving newrelic yml" do
    command "cp -f /opt/tomcat7/newrelic.yml /usr/local/tomcat-7.0.53/newrelic/newrelic.yml"
    group node['newrelic']['java_agent']['app_group']
    user node['newrelic']['java_agent']['app_user']
end

  ruby_block "waiting 30 sec" do 
    block do 
        sleep(30)
    end
end

execute "start tomcat" do 
    command "service tomcat7 start"
end

include_recipe 'newrelic::server_monitor_agent'