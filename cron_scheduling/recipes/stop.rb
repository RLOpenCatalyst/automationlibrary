	include_recipe 'cron_scheduling::init'

	runningNodeObj = node[:cron_scheduling][:runningNodes]	
	no_of_nodes	   = node[:cron_scheduling][:no_of_nodes]
	token          = node[:cron_scheduling][:token]
	catalyst_url   = node[:cron_scheduling][:catalyst][:url]
	role		   = node[:cron_scheduling][:role]

if no_of_nodes != nil && runningNodeObj != nil
	no_of_nodes.each do |instance|
	instance_id=instance['ec2']['instance_id']

	#to stop the instance
	 for x in runningNodeObj do 	
			if x["platformId"]==instance_id 
				http_request 'stop instance' do
					catalystId=x['_id']
					url "#{catalyst_url}/instances/#{catalystId}/stopInstance"
				   	action :get
					headers  ({"x-catalyst-auth"=>token})				
				end
		 	end
		 end
	 end
end
