#
# Cookbook Name:: docker_deploy
# Recipe:: default
#
# Copyright (C) 2016 YOUR_NAME
#
# All rights reserved - Do Not Redistribute
#
# docker deploy data bag
# 2 data bag items, for each item do the docker install.

include_recipe "docker_deploy::validator"


dockerUser = node["rlcatalyst"]["dockerUser"]
dockerPassword = node["rlcatalyst"]["dockerPassword"]
dockerEmailId = node["rlcatalyst"]["dockerEmailId"]
dockerImage = node["rlcatalyst"]["dockerImage"]
imageTag = node["rlcatalyst"]["imageTag"]
containerPort = node["rlcatalyst"]["containerPort"]
hostPort = node["rlcatalyst"]["hostPort"]
container_command = node["rlcatalyst"]["container_command"]
containerId = node["rlcatalyst"]["containerId"]
applicationNodeIP = node["rlcatalyst"]["applicationNodeIP"]
upgrade = node["rlcatalyst"]["upgrade"]

puts "********Start Printing attributes*********"
  puts "dockerUser:: #{dockerUser}"
  puts "dockerPassword:: #{dockerPassword}"
  puts "dockerEmailId:: #{dockerEmailId}"
  puts "dockerImage:: #{dockerImage}"
  puts "imageTag:: #{imageTag}"
  puts "containerPort:: #{containerPort}"
  puts "hostPort:: #{hostPort}"
  puts "container_command:: #{container_command}"
  puts "containerId:: #{containerId}"
  puts "applicationNodeIP:: #{applicationNodeIP}"
  puts "upgrade:: #{upgrade}"
  puts "callbackURL::#{node[:rlcatalyst][:callbackURL]}"
puts "********End Printing attributes*********"


docker_service 'default' do
  #tls_verify false
  action [:create, :start]
end

# # logs into the docker hub and and pull the specific image 
if dockerUser && !dockerUser.empty?
     execute "pull private repo" do
    #if dockerImage && !dockerImage.empty? then
      command "docker login -u #{"#{dockerUser}"} -p #{"#{dockerPassword}"} -e #{"#{dockerEmailId}"} && docker pull #{"#{dockerImage}"}:#{"#{imageTag}"}"
    #else 
    #  command "docker login -u #{"#{dockerUser}"} -p #{"#{dockerPassword}"} -e #{"#{dockerEmailId}"}"
    #end    
  end 

else
 docker_image dockerImage do
    tag imageTag
    action :pull
    retries 2
    #notifies :redeploy, 'docker_container[catalyst]'
  end
end


if upgrade == true
  docker_container "delete_old" do 
    container_name containerId
    kill_after 30
    action [:stop,:delete]
  end
end

container_volumes = Array(node[:rlcatalyst][:ContainerVolumes])

docker_container "run container" do
  container_name containerId
  repo dockerImage
  tag imageTag
  tty true
  port "#{node[:rlcatalyst][:hostPort]}:#{node[:rlcatalyst][:containerPort]}"
  volumes container_volumes
  restart_policy 'on-failure'
  restart_maximum_retry_count 2
  action [:run, :start]
end  

ruby_block "sleep 60" do 
  block do
    puts "Waiting for the container to be up and running .............."
    sleep(60)
    
    status = %x(docker ps | grep #{containerId}).empty?
    node.default[:rlcatalyst][:applicationStatus] = status ? "Failure" : "Successful"
  end
end

#unless "#{container_command}".nil?
#  execute "sudo docker exec #{"#{containerId}"} #{"#{container_command}"}"
#end


ipaddrs = node['cloud'].nil? ? node['ipaddress'] : (node['cloud']['public_ipv4'].nil? ? node['cloud']['local_ipv4'] : node['cloud']['public_ipv4'])
repoid = "#{dockerImage}".split("/").last

ruby_block "Update App data" do
        block do
                node.default['app_data_handler']['catalystCallbackUrl'] = node[:rlcatalyst][:callbackURL]
                node.default['app_data_handler']['app']['containerId'] = "#{containerId}"
                node.default['app_data_handler']['app']['applicationType'] = "Container"
                node.default['app_data_handler']['app']['applicationName'] = dockerImage
                node.default['app_data_handler']['app']['applicationVersion'] = "#{imageTag}"
                node.default['app_data_handler']['app']['applicationInstanceName'] = repoid
                node.default['app_data_handler']['app']['applicationNodeIP'] = ipaddrs
                node.default['app_data_handler']['app']['applicationStatus'] = node[:rlcatalyst][:applicationStatus] 
        end
end

include_recipe "app_data_handler"
