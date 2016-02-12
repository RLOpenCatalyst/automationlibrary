catalystCallbackUrl = node["deploy_upgrade_catalyst"]["catalystCallbackUrl"]
url = node["rlcatalyst"]["nexusUrl"]
app_version = node["rlcatalyst"]["version"]
applicationNodeIP = node["rlcatalyst"]["applicationNodeIP"]
package_type = url.split(".").last               #zip
app_name = url.split("/").last.split("-").first  #D4d
repo = url.split("/").values_at(6)
package_name = url.split("/").last                    #D4D-2.1.10.zip
package = "#{app_name}" + "-" + "#{app_version}" #D4D-2.1.10
download_dir = node["deploy_upgrade_catalyst"]["download_dir"]
repoid = url.split("repositories/")[1].split("/")[0]

puts "url :: #{url}"
puts "version :: #{app_version}"
puts "package_type :: #{package_type}"
puts "app_name :: #{app_name}"
puts "package_name :: #{package_name}"
puts "catalystCallbackUrl :: #{catalystCallbackUrl}"
puts "repoid :: #{repoid}"
puts "applicationNodeIP :: #{applicationNodeIP}"

directory "#{download_dir}/#{app_name}" do
action :delete
recursive true
only_if {Dir.exists?("#{download_dir}/#{app_name}")}
end

package "unzip"

package "zip"

#directory "" do
#action :delete
#not_if {Dir.exists?("")}
#end

remote_file "#{download_dir}/#{package_name}" do
  owner 'root'
  group 'root'
  mode '0644'
  source "#{url}"
end

execute "unzip" do
  user "root"
  group "root"
  cwd "#{download_dir}"
  action :run
  command "unzip #{package_name}"
end

target_dir="#{Chef::Config[:file_cache_path]}/#{repoid}/#{package}"

ruby_block "upgrade" do
        block do
                require 'fileutils'
                FileUtils.cp_r(Dir["/tmp/#{app_name}/*"], "#{target_dir}")
        end
end

# kill existing or running node apps
# By default kills all running node apps 
# This behavior needs to be changed
execute "kill node" do
command "killall nodejs | echo"
ignore_failure false
end

execute 'run app.js' do
  cwd "#{target_dir}/server"
  command 'sudo npm install && sudo node install --seed-data && sudo npm install -g forever && killall nodejs | echo && sudo forever start app.js'
  action :run
end

puts "This is the version of the app ::  #{app_version}"

check_status = %x(ps -ef | grep app.js)
puts "check_status:: #{check_status}"
if check_status.empty? then
  appStatus = "Failure"
else
  appStatus = "Successful"
end
puts "Application Status:: #{appStatus}"

ruby_block "Update App data" do
        block do
                node.default['app_data_handler']['catalystCallbackUrl'] = "#{catalystCallbackUrl}"
               node.default['app_data_handler']['app']['applicationName'] = "#{repoid}"
               # version =  JSON.load(File.read("#{target_dir}/version.json"))["version"]
                node.default['app_data_handler']['app']['applicationVersion'] = "#{app_version}"
                node.default['app_data_handler']['app']['applicationType'] = "Package"
                node.default['app_data_handler']['app']['containerId'] = "NA"
                node.default['app_data_handler']['app']['applicationInstanceName'] = "Supercatalyst"
                node.default['app_data_handler']['app']['applicationNodeIP'] = "#{applicationNodeIP}"
                node.default['app_data_handler']['app']['applicationStatus'] = "#{appStatus}"
                
        end
end

include_recipe "app_data_handler"
