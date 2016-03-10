#
# Cookbook Name:: deploy_war
# Recipe:: default
#
# Copyright (C) 2016 YOUR_NAME
#
# All rights reserved - Do Not Redistribute
#
=begin 
1. check the tomcat7 is running or not
2. check the webapps directory
3. if it present, stop tomcat7 server and Download the war file
4. start the tomcat7 service.
=end

ruby_block "check tomcat installation" do 
	block do
		if Dir.exist?("/var/lib/tomcat7/webapps")
		  node.default[:tomcat7][:app_home] = "/var/lib/tomcat7/webapps"
		elsif Dir.exist?("/opt/tomcat7/webapps")
		  node.default[:tomcat7][:app_home] = "/opt/tomcat7/webapps"
		else
			Chef::Log.info("Node does not contain Tomcat7 installed. Please install tomcat7")	
		end

		user = %x(stat -c "%U" #{node[:tomcat7][:app_home]})
		#user = %x(cut -d: -f1 /etc/passwd | grep '^tomcat')
		puts "Tomcat User: #{user}"
		node.default[:tomcat7][:user] = node.default[:tomcat7][:group] = user[0..-2]

		if node["rlcatalyst"]["nexusUrl"].nil? && node[:deploy_war][:source_url].nil?
			puts "Nothing to do, url and version are not specified"
			Chef::Log.info("Nothing to do, url are not specified")
		elsif !node["rlcatalyst"]["nexusUrl"].nil?	
			run_context.include_recipe "deploy_war::deploy_war_nexus"
		elsif !node[:deploy_war][:source_url].nil?
			run_context.include_recipe "deploy_war::deploy_war_url"
		end
	end
end
