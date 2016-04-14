dockerUser = node["rlcatalyst"]["dockerUser"]
dockerPassword = node["rlcatalyst"]["dockerPassword"]
dockerEmailId = node["rlcatalyst"]["dockerEmailId"]
dockerImage = node["rlcatalyst"]["dockerImage"]
imageTag = node["rlcatalyst"]["imageTag"]
containerPort = node["rlcatalyst"]["containerPort"]
hostPort = node["rlcatalyst"]["hostPort"]
container_command = node["rlcatalyst"]["container_command"]
containerId = node["rlcatalyst"]["containerId"]


if dockerImage.nil? || dockerImage.empty? 
	Chef::Application.fatal!("Provide the docker image name to pull/ create container with", 150) 
elsif containerId.nil? || containerId.empty?
	Chef::Application.fatal!("Please provide the container name you ant to run with", 151)
elsif imageTag.nil? || imageTag.empty?
	Chef::Log.info("Image tag is not mentioned so latest is taken as default")
elsif containerPort.nil? || containerPort.empty? || hostPort.nil? || hostPort.empty?
	#node.default[:rlcatalyst][:publish_all_ports] = true
	Chef::Application.fatal!("Biding ports are not mentioned.")
elsif dockerUser && !dockerUser.empty?
	if dockerPassword.nil? || dockerPassword.empty? || dockerEmailId.nil? || dockerEmailId.empty?
		Chef::Application.fatal!("Please provide the docker hub password and registered email for #{dockerUser}", 152)
	end	
end

