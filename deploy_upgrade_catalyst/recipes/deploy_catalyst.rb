# Cookbook Name:: deploy_upgrade_rlcatalyst
# Recipe:: deploy_catalyst
#
# Copyright (C) 2015 Relevance Lab pvt ltd.
#
# All rights reserved - Do Not Redistribute


include_recipe "deploy_upgrade_catalyst::env_update"
 
url = node["rlcatalyst"]["nexusUrl"] || node[:deploy_upgrade_catalyst][:app_source_url] 
repo_id = url.split("/").last
repo_name = repo_id.split('-')[0]
app_version = node["rlcatalyst"]["version"] || node[:deploy_upgrade_catalyst][:app_version] 

puts node["rlcatalyst"]["nexusUrl"]
puts node["rlcatalyst"]["version"]

remote_file "/opt/#{repo_id}" do
  owner 'root'
  group 'root'
  mode '0644'
  source url
end

package 'unzip'

direc = Dir.glob("./opt/**/version.json")

unless direc.empty?
  repo_folder = direc.first.split('opt/')[1].split("/")[0]
  directory "/opt/#{repo_folder}" do 
    action :delete
    recursive true
  end
end

execute "unzip #{repo_id}" do
  user "root"
  group "root"
  cwd "/opt"
  action :run
  command "unzip #{repo_id}"
end  

ruby_block "get repo_folder" do
    block do 
    version_path = Dir.glob("/opt/**/version.json").first
    puts "Parent directory:: #{version_path}"
    app_home = version_path.split('opt/')[1].split("/")[0]
    node.default[:deploy_upgrade_catalyst][:app_home] = "/opt/#{app_home}/server"
	end
end

execute "kill node" do
	command "killall nodejs | echo"
	ignore_failure false
end

execute 'sudo npm install' do 
  cwd lazy { node[:deploy_upgrade_catalyst][:app_home] }
end

sleep(10)

execute 'sudo node install --seed-data' do 
 cwd lazy { node[:deploy_upgrade_catalyst][:app_home] }
end

execute 'sudo npm install forever -g' do 
  cwd lazy { node[:deploy_upgrade_catalyst][:app_home] }
end

sleep (5)

execute 'sudo forever start app.js' do 
  cwd lazy { node[:deploy_upgrade_catalyst][:app_home] }
end


puts "This is the version of the app ::  #{app_version}"

check_status = %x(ps -ef | grep app.js)
puts "check_status:: #{check_status}"
if check_status.empty? then
  node.default[:deploy_upgrade_catalyst][:deploy_status] = "Failure"
else
  node.default[:deploy_upgrade_catalyst][:deploy_status] = "Successful"
end
puts "Application Status:: #{node[:deploy_upgrade_catalyst][:deploy_status]}"

ruby_block "Update App data" do
        block do
                node.default['app_data_handler']['catalystCallbackUrl'] = node["deploy_upgrade_catalyst"]["catalystCallbackUrl"]
                node.default['app_data_handler']['app']['applicationName'] = repo_name
                node.default['app_data_handler']['app']['applicationVersion'] = app_version
                node.default['app_data_handler']['app']['applicationType'] = "Package"
                node.default['app_data_handler']['app']['containerId'] = "NA"
                node.default['app_data_handler']['app']['applicationInstanceName'] = "Supercatalyst"
                node.default['app_data_handler']['app']['applicationNodeIP'] = node["rlcatalyst"]["applicationNodeIP"]
                node.default['app_data_handler']['app']['applicationStatus'] = node[:deploy_upgrade_catalyst][:deploy_status]
                
        end
end

include_recipe "app_data_handler"





