#
# Cookbook Name:: scheduling
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#


require 'json'
#Authenticate Catalyst ad get token id
username		=	node[:cron_scheduling][:catalyst][:username]
password		=	node[:cron_scheduling][:catalyst][:password]
catalyst_url	=	node[:cron_scheduling][:catalyst][:url]
role			=	node[:cron_scheduling][:role]
if role !='' 
	role			=	'roles:'+ node[:cron_scheduling][:role]
end

	if username != '' && password != '' && catalyst_url != '' && role != ''
	#Authenticate Catalyst and get token id for the session
	token = `curl -H "Content-Type: application/json" -X POST -d '{"username":"#{username}",
    "pass":"#{password}",
        "authType": "token"}' #{catalyst_url}/auth/signin`
	tokenObj=JSON.parse(token)
	token = tokenObj["token"]

	
	#get list of nodes for a particular role
	
	no_of_nodes = search(:node, "roles:#{node[:cron_scheduling][:role]}")
	
	#Get list of instances available in Catalyst
	http = Chef::HTTP.new(catalyst_url)
	json_string = http.get('/instances', headers = {"x-catalyst-auth"=>token})
	obj = JSON.parse(json_string)
	stoppedNodeObj= obj.select {|h1| h1['instanceState']=='stopped'}
	runningNodeObj= obj.select {|h1| h1['instanceState']=='running'}
	
	node.default[:cron_scheduling][:stoppedNodes]	=	stoppedNodeObj
	node.default[:cron_scheduling][:runningNodes]	=	runningNodeObj
	node.default[:cron_scheduling][:no_of_nodes]	=	no_of_nodes
	node.default[:cron_scheduling][:token]			=	token

end



