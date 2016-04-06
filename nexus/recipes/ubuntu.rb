# nexus on ubuntu

group node['nexus']['group'] do
  action :create
  gid  '1234'
  append true
end

user node['nexus']['user'] do
  supports :manage_home => true
  comment 'User nexus'
  group  node['nexus']['group']
  home '/home/nexus'
  shell '/bin/bash'
end

execute 'update' do
  command "sudo apt-get update -y"
  action :run
end

package node['nexus']['java']['packagename']

ark 'nexus' do
  version '2.12.0-01'
  url node['nexus']['download']['url']
  owner node['nexus']['user']
end

['/etc/srv/nexus', '/etc/srv/nexus/main-repo', '/var/run/nexus'].each do |dirname|
  directory "#{dirname}" do
    owner node['nexus']['user']
    group node['nexus']['group']
    recursive true
    action :create
  end
end

template '/usr/local/nexus-2.12.0-01/conf/nexus.properties' do
  source "nexus.properties.erb"
  owner node['nexus']['user']
  group node['nexus']['group']
  mode 0644
end

file '/var/run/nexus/nexus.pid' do
  owner node['nexus']['user']
  group node['nexus']['group']
  mode '0644'
  action :create_if_missing
end

template '/etc/init.d/nexus' do
  source "nexus.erb"
  owner node['nexus']['user']
  group node['nexus']['group']
  mode 0755
end

service 'nexus' do
  supports :start => true, :stop => true, :restart => true
  action [ :enable, :start ]
end
