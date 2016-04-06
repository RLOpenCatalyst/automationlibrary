default[:deploy_upgrade_catalyst][:catalystCallbackUrl] = "http://d4d.rlcatalyst.com/app/deploy"
#"http://supercatalyst.relevancelab.com/app/deploy"
#"http://d4d.rlcatalyst.com/app/deploy
default[:rlcatalyst][:nexusUrl] = nil
default[:rlcatalyst][:version] = nil
default[:rlcatalyst][:containerId] = nil
default[:rlcatalyst][:containerPort] = nil
default[:rlcatalyst][:dockerRepo] = nil
default[:rlcatalyst][:upgrade] = nil
default[:rlcatalyst][:applicationNodeIP] = nil

#default[:deploy_upgrade_catalyst][:app_home] = 'NA'
default[:deploy_upgrade_catalyst][:target_dir] = "/opt"
default[:deploy_upgrade_catalyst][:download_dir] = "/opt"
default[:deploy_upgrade_catalyst][:target_dir] = nil
default[:deploy_upgrade_catalyst][:deploy_status] = nil
default[:deploy_upgrade_catalyst][:app_version] = nil
default[:deploy_upgrade_catalyst][:app_source_url] =nil
default[:deploy_upgrade_catalyst][:repo_source] = 'https://nodejs.org/dist/v4.2.2/node-v4.2.2-linux-x64.tar.gz'

default[:nodejs][:version] = "4.2.2"
default[:nodejs][:npm][:version] = "3.5.2"
default[:nodejs][:npm][:install_method] = "source"

default[:nodejs][:install_repo] = false
