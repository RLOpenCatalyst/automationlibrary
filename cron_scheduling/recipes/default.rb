#
# Cookbook Name:: cron_scheduling
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
x=`ls -Art /home/ubuntu | tail -n 1`
puts x
 #p1= `Dir.glob(File.join("/home/ubuntu",'*')).select{|f| File.file? f}.sort_by {|f| File.mtime f}.last`

#x=`Dir["/home/ubuntu/*.json"].sort_by{|file_name|File.stat(file_name).ctime }.last` 

cron 'start_machine' do
	command		"/usr/bin/chef-client --runlist 'recipe[cron_scheduling::start]' -j /home/ubuntu/#{x}"
	provider	Chef::Provider::Cron
	day 		'*'
	hour		node[:cron_scheduling][:start][:hour]
	minute		node[:cron_scheduling][:start][:minute]	
	weekday 	'1-5'
	action        :create
end

cron 'stop_machine' do
	command         "/usr/bin/chef-client --runlist 'recipe[cron_scheduling::stop]'  -j /home/ubuntu/#{x}"
       provider     Chef::Provider::Cron       
       day          '*'
       hour			node[:cron_scheduling][:stop][:hour]
	   minute		node[:cron_scheduling][:stop][:minute]
       weekday      '1-5'
       action       :create
end
cron 'create' do
	command         "mkdir /tmp/test"
       provider     Chef::Provider::Cron       
       day          '*'
       hour			node[:cron_scheduling][:stop][:hour]
	   minute		node[:cron_scheduling][:stop][:minute]
       weekday      '1-5'
       action       :create
end




