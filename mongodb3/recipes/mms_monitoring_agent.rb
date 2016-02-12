#
# Cookbook Name:: mongodb3
# Recipe:: mms_monitoring_agent
#
# Copyright 2015, Sunggun Yu
#
# Licensed under the Apache License, Version 2.0 (the 'License');
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an 'AS IS' BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# Install curl
package 'curl' do
  action :install
end

# Set variables by platform
case node['platform_family']
  when 'rhel', 'fedora'
    mms_agent_source = 'https://cloud.mongodb.com/download/agent/monitoring/mongodb-mms-monitoring-agent-latest.x86_64.rpm'
    mms_agent_file = '/root/mongodb-mms-monitoring-agent-latest.x86_64.rpm'
  when 'debian'
    mms_agent_source = 'https://cloud.mongodb.com/download/agent/monitoring/mongodb-mms-monitoring-agent_latest_amd64.deb'
    mms_agent_file = '/root/mongodb-mms-monitoring-agent_latest_amd64.deb'
end

# Download the mms automation agent manager latest
remote_file mms_agent_file do
  source mms_agent_source
  action :create
end

# Install package
case node['platform_family']
  when 'rhel', 'fedora'
    rpm_package 'mongodb-mms-monitoring-agent' do
      source mms_agent_file
      action :install
    end
  when 'debian'
    dpkg_package 'mongodb-mms-monitoring-agent' do
      source mms_agent_file
      action :install
    end
end

# Create or modify the mms agent config file
template '/etc/mongodb-mms/monitoring-agent.config' do
  source 'monitoring-agent.config.erb'
  mode 0600
  owner 'mongodb-mms-agent'
  group 'mongodb-mms-agent'
  variables(
      :config => node['mongodb3']['config']['mms']
  )
end

# Start the mms automation agent
service 'mongodb-mms-monitoring-agent' do
  # The service provider of MMS Agent for Ubuntu is upstart
  provider Chef::Provider::Service::Upstart if node['platform_family'] == 'debian'
  supports :status => true, :restart => true, :stop => true
  action [ :enable, :start ]
end
