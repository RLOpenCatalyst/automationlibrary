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
		# catalina_base = %x(echo $CATALINA_BASE)
		# if catalina_base.empty?
		# 	puts "CATALINA_BASE is not found, please install tomcat"
		# else
		# 	puts catalina_base
		# 	node.default[:tomcat7][:app_home] = File.join(catalina_base, "webapps")
		# end
		
		if Dir.exist?("/opt/tomcat7/webapps")
		  node.default[:tomcat7][:app_home] = "/opt/tomcat7/webapps"
		elsif Dir.exist?("/var/lib/tomcat7/webapps")
		  node.default[:tomcat7][:app_home] = "/var/lib/tomcat7/webapps"
		else
			Chef::Log.info("Node does not contain Tomcat7 installed. Please install tomcat7")	
		end

		user = %x(cut -d: -f1 /etc/passwd | grep '^tomcat')
		puts "Tomcat User: #{user}"
		node.default[:tomcat7][:user] = node.default[:tomcat7][:group] = user[0..-2].split("\n").first

		unless node["rlcatalyst"]["nexusUrl"].nil?
			run_context.include_recipe "deploy_war::deploy_war"
		else
			puts "Nothing to do, url and version are not specified"
			Chef::Log.info("Nothing to do, url are not specified")
		end
	end
end