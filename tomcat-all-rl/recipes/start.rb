#
# Cookbook Name:: tomcat-all-rl
# Recipe:: start
# Copyright 2015, Relevance Lab pvt ltd.
#
# All rights reserved - Do Not Redistribute
#


tomcat_version = node['tomcat-all-rl']['version']
major_version = tomcat_version[0]


tomcat_home = node['tomcat-all-rl']['tomcat_home']

execute "Start Tomcat#{major_version} " do

	command "cd #{tomcat_home}/bin/
			 sudo ./startup.sh"
action :run
ignore_failure true
end


# service "tomcat#{major_version}" do
#   action :start
# end
