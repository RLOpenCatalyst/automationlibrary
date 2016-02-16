#
# Cookbook Name:: tomcat-all-rl
# Recipe:: default
# Copyright 2015, Relevance Lab pvt ltd.
#
# All rights reserved - Do Not Redistribute
#

execute 'apt-get update' do
  command 'apt-get update'
end

include_recipe "java"
=begin
	if platform_family?("redhat", "centos", "fedora")
		include_recipe "sudo"
	end
=end

# Build download URL
tomcat_version = node['tomcat-all-rl']['version']
major_version = tomcat_version[0]
download_url = "http://archive.apache.org/dist/tomcat/tomcat-#{major_version}/v#{tomcat_version}/bin/apache-tomcat-#{tomcat_version}.tar.gz"

# Create group
group node['tomcat-all-rl']['group']

# Create user
user node['tomcat-all-rl']['user'] do
  group node['tomcat-all-rl']['group']
  system true
  shell '/bin/bash'
end

# Download and unpack tomcat
ark 'tomcat' do
  url download_url
  version node['tomcat-all-rl']['version']
  home_dir node['tomcat-all-rl']['tomcat_home']
  owner node['tomcat-all-rl']['user']
  group node['tomcat-all-rl']['group']
end

execute "change permissions" do
	command "chown -R tomcat:tomcat /opt/tomcat7/logs"
	action :run
end

# Log rotation (catalina.out)
template '/etc/logrotate.d/tomcat' do
  source 'logrotate.conf.erb'
  mode '0644'
  owner node['tomcat-all-rl']['user']
  group node['tomcat-all-rl']['group']
end

# Tomcat server configuration
template "#{node['tomcat-all-rl']['tomcat_home']}/conf/server.xml" do
  source 'server.conf.erb'
  mode '0644'
  owner node['tomcat-all-rl']['user']
  group node['tomcat-all-rl']['group']
end

# Tomcat catalina configuration
template "#{node['tomcat-all-rl']['tomcat_home']}/bin/setenv.sh" do
  source 'setenv.sh.erb'
  mode '0755'
  owner node['tomcat-all-rl']['user']
  group node['tomcat-all-rl']['group']
end

# Tomcat init script configuration
template "/etc/init.d/tomcat#{major_version}" do
  source 'init.conf.erb'
  mode '0755'
  owner node['tomcat-all-rl']['user']
  group node['tomcat-all-rl']['group']
end

# Tomcat Config for Manager App

template "#{node['tomcat-all-rl']['tomcat_home']}/conf/tomcat-users.xml" do
  source 'tomcat-users.xml.erb'
  mode '0644'
  owner node['tomcat-all-rl']['user']
  group node['tomcat-all-rl']['group']
end


include_recipe 'tomcat-all-rl::set_tomcat_home'

# Create default catalina.pid file to prevent restart error for 1st run of coookbook.
file "#{node['tomcat-all-rl']['tomcat_home']}/catalina.pid" do
  owner node['tomcat-all-rl']['user']
  group node['tomcat-all-rl']['group']
  mode '0755'
  action :create
  not_if { ::File.exist?("#{node['tomcat-all-rl']['tomcat_home']}/catalina.pid") }
end

# Enabling tomcat service and restart the service if subscribed template has changed.
# service "tomcat#{major_version}" do
#   supports :restart => true
#   subscribes :restart, "template[/etc/init.d/tomcat#{major_version}]", :delayed
#   subscribes :restart, "template[#{node['tomcat-all-rl']['tomcat_home']}/bin/setenv.sh]", :delayed
#   subscribes :restart, "template[#{node['tomcat-all-rl']['tomcat_home']}/conf/server.xml]", :delayed
# end




include_recipe "tomcat-all-rl::stop"
sleep (5)
include_recipe "tomcat-all-rl::start"


	if platform_family?("debian")

		execute "Update IPTables" do
			command "sudo ufw disable"
			action :run
		end  
	else
		execute "Update IPTables" do
			command "/etc/init.d/iptables stop"
			action :run
		end
	end

#start at boottime
        if platform_family?("debian")

                execute "start at boottime" do
                        command "sudo update-rc.d tomcat#{major_version} defaults"
                        action :run
                end
        else
                execute "start at boottime" do
                        command "chkconfig --add tomcat#{major_version};chkconfig tomcat#{major_version} on"
                        action :run
                end
        end

execute "change permissions" do
        command "chown -R tomcat:tomcat /opt/tomcat7/*"
        action :run
end

execute "kill" do
command "kill -9 `pidof java`"
action :run
ignore_failure true
end

execute "start tomcat" do
command "/etc/init.d/tomcat7 start"
action :run
ignore_failure true
end
=begin
if platform_family?("debian")
directory "/mnt/jenkins" do
group "ubuntu"
owner "ubuntu"
mode "755"
recursive true
action :create
end
else
=end
directory "/mnt/jenkins" do
group "root"
owner "root"
mode "755"
recursive true
action :create
end