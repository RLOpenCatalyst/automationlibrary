#
# Cookbook Name:: newrelic
# Attributes:: java_agent
#
# Copyright 2012-2015, Escape Studios
#

default['newrelic']['java_agent']['version'] = 'latest'
default['newrelic']['java_agent']['install_dir'] = '/opt/tomcat7'
default['newrelic']['java_agent']['app_user'] = 'tomcat'
default['newrelic']['java_agent']['app_group'] = 'tomcat'
default['newrelic']['java_agent']['audit_mode'] = false
default['newrelic']['java_agent']['log_file_count'] = 1
default['newrelic']['java_agent']['log_limit_in_kbytes'] = 0
default['newrelic']['java_agent']['log_daily'] = true
default['newrelic']['java_agent']['agent_action'] = :install
default['newrelic']['java_agent']['execute_agent_action'] = true
default['newrelic']['java_agent']['enable_custom_tracing'] = false
default['newrelic']['java_agent']['app_location'] = node['newrelic']['java_agent']['install_dir']
default['newrelic']['java_agent']['template']['cookbook'] = 'newrelic'
default['newrelic']['java_agent']['template']['source'] = 'agent/newrelic.yml.erb'
