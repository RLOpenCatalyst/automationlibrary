
# Cookbook Name:: deploy_upgrade_catalyst
# Recipe:: container
#
# Copyright 2015, Relevance Lab pvt ltd.
#
# All rights reserved - Do Not Redistribute
#

catalystCallbackUrl = node["deploy_upgrade_catalyst"]["catalystCallbackUrl"]
target_dir = node["deploy_upgrade_catalyst"]["target_dir"]
url = node["rlcatalyst"]["nexusUrl"]
version = node["rlcatalyst"]["version"]
download_dir = node["deploy_upgrade_catalyst"]["download_dir"]
containerId = node["rlcatalyst"]["containerId"]
containerPort = node["rlcatalyst"]["containerPort"]
applicationNodeIP = node["rlcatalyst"]["applicationNodeIP"]
#repoid = url.split("repositories/")[1].split("/")[0]
#package_type = url.split(".").last               #zip
#app_name = url.split("/").last.split("-").first  #D4d
#package_name = url.split("/").last                    #D4D-2.1.10.zip
#version = url.split("/").last.split("-").last.split(".").first(3).join(".") #2.1.10
#package = "#{app_name}" + "-" + "#{version}"

dockerRepo = node["rlcatalyst"]["dockerRepo"]
upgrade = node["rlcatalyst"]["upgrade"]
repoid = ""
package_type = ""
app_name = ""
package_name = ""
version = ""
package = ""
puts "Incomming docker repo: #{dockerRepo}"
if dockerRepo == "NA" || dockerRepo == ""
  repoid = url.split("repositories/")[1].split("/")[0]
  package_type = url.split(".").last               #zip
  app_name = url.split("/").last.split("-").first  #D4d
  package_name = url.split("/").last                    #D4D-2.1.10.zip
  version = url.split("/").last.split("-").last.split(".").first(3).join(".") #2.1.10
  package = "#{app_name}" + "-" + "#{version}"

else
 repoid = dockerRepo.split("/")[1]
end
puts "url :: #{url}"
puts "version :: #{version}"
puts "package_type :: #{package_type}"
puts "app_name :: #{app_name}"
puts "package_name :: #{package_name}"
puts "target_dir:: #{target_dir}"
puts "catalystCallbackUrl :: #{catalystCallbackUrl}"
puts "containerID :: #{containerId}"
puts "containerPort :: #{containerPort}"
puts "dockerRepo :: #{dockerRepo}"
puts "applicationNodeIP :: #{applicationNodeIP}"


docker_installation 'default' do
  repo 'main'
  action :create
end

docker_installation_script 'default' do
  repo 'main'
  action :create
end

docker_installation_package 'default' do
  version '1.9.1'
  action :create
end

directory "/root/.docker" do
user "root"
group "root"
action :nothing
end.run_action(:create)


docker_image "#{dockerRepo}" do
  tag 'latest'
  action :pull
end

checkRunningPort = %x(docker ps | grep #{containerPort})
puts "Running Container with Port: #{checkRunningPort}"

if !checkRunningPort.empty? then
  puts "Port #{containerPort} is already running.Please choose different port."
  exit
end


container_exists = %x(docker ps | grep #{containerId})
puts "container_exists: #{container_exists}"
if container_exists.empty? then

portnum = "#{containerPort}"

docker_container "#{containerId}" do
  repo "#{dockerRepo}"
  tag 'latest'
  command "/bin/bash"
  tty true
  port "#{portnum}:3001"
  action [:run, :start]
end  

puts "Waiting for the container to run"
sleep 30


template '/tmp/installcat.sh' do
  source 'installcat.sh.erb'
  owner 'root'
  group 'root'
  mode '0755'
  only_if {Dir.exists?("/tmp")}
  variables ({
        :repoid => "#{repoid}",
        :package => "#{package}",
        :target => "#{target_dir}",
        :url => "#{url}",
        :app_name => "#{app_name}",
        :package_name => "#{package_name}"
    })
end

ruby_block "Update App data" do
        block do
                node.default['app_data_handler']['catalystCallbackUrl'] = "#{catalystCallbackUrl}"
                node.default['app_data_handler']['app']['containerId'] = "#{containerId}"
                node.default['app_data_handler']['app']['applicationType'] = "Container"
                node.default['app_data_handler']['app']['applicationName'] = "#{repoid}"
                # version =  JSON.load(File.read("#{target_dir}/version.json"))["version"]
                node.default['app_data_handler']['app']['applicationVersion'] = "#{version}"
                node.default['app_data_handler']['app']['applicationInstanceName'] = "Supercatalyst"
                node.default['app_data_handler']['app']['applicationNodeIP'] = "#{applicationNodeIP}"
                
        end
end

include_recipe "app_data_handler"

elsif upgrade == "true"

portnum = "#{containerPort}"


# Remove already running container
%x(docker rm -f #{containerId})
puts "Waiting to delete already running container: #{containerId}"
sleep 20

docker_container "#{containerId}" do
  repo "#{dockerRepo}"
  tag 'latest'
  command "/bin/bash"
  tty true
  port "#{portnum}:3001"
  action [:run, :start]
end  

puts "Waiting for the container to run"
sleep 30

template '/tmp/installcat.sh' do
  source 'installcat.sh.erb'
  owner 'root'
  group 'root'
  mode '0755'
  only_if {Dir.exists?("/tmp")}
  variables ({
        :repoid => "#{repoid}",
        :package => "#{package}",
        :target => "#{target_dir}",
        :url => "#{url}",
        :app_name => "#{app_name}",
        :package_name => "#{package_name}"
    })
end


ruby_block "Update App data" do
        block do
                node.default['app_data_handler']['catalystCallbackUrl'] = "#{catalystCallbackUrl}"
                node.default['app_data_handler']['app']['containerId'] = "#{containerId}"
                node.default['app_data_handler']['app']['applicationType'] = "Container"
                node.default['app_data_handler']['app']['applicationName'] = "#{repoid}"
                # version =  JSON.load(File.read("#{target_dir}/version.json"))["version"]
                node.default['app_data_handler']['app']['applicationVersion'] = "#{version}"
                node.default['app_data_handler']['app']['applicationInstanceName'] = "Supercatalyst"
                node.default['app_data_handler']['app']['applicationNodeIP'] = "#{applicationNodeIP}"
                
        end
end

include_recipe "app_data_handler"

 else 

puts "container already exists, please choose diffrent name/id"

end
