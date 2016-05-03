
catalystCallbackUrl = node[:rlcatalyst][:CallbackUrl]
repo_name = node[:multitier][:app_name] + "_db"
db_release_version = node[:rlcatalyst][:db_release_version]
status = "successful"

ipaddrs = node['cloud'].nil? ? node['ipaddress'] : node['cloud']['public_ipv4']

ruby_block "Update App data" do
    block do
        node.default['app_data_handler']['catalystCallbackUrl'] = node[:rlcatalyst][:CallbackUrl]
        node.default['app_data_handler']['app']['applicationName'] = repo_name
        node.default['app_data_handler']['app']['applicationVersion'] = db_release_version.to_s
        node.default['app_data_handler']['app']['applicationType'] = "Database Update"
        node.default['app_data_handler']['app']['containerId'] = "NA"
        node.default['app_data_handler']['app']['applicationInstanceName'] = repo_name
        node.default['app_data_handler']['app']['applicationNodeIP'] = ipaddrs
        node.default['app_data_handler']['app']['applicationStatus'] = status
            
    end
end

include_recipe "app_data_handler"
