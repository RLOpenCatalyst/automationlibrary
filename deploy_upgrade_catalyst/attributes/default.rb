default["deploy_upgrade_catalyst"]["catalystCallbackUrl"] = "http://d4d.rlcatalyst.com/app/deploy"
#"http://supercatalyst.relevancelab.com/app/deploy"
#"http://d4d.rlcatalyst.com/app/deploy
default["rlcatalyst"]["nexusUrl"] = "NA"
default["rlcatalyst"]["version"] = "NA"
default["deploy_upgrade_catalyst"]["target_dir"] = "/opt"
default["deploy_upgrade_catalyst"]["download_dir"] = "/tmp"
default['deploy_upgrade_catalyst']['target_dir'] = "NA"
default['rlcatalyst']['containerId'] = "NA"
default['rlcatalyst']['containerPort'] = "NA"
default["rlcatalyst"]["dockerRepo"] = "NA"
default["rlcatalyst"]["upgrade"] = "NA"
default["rlcatalyst"]["applicationNodeIP"] = "NA"



default[:nodejs][:version] = "4.2.2"
default[:nodejs][:npm][:version] = "3.5.2"
default[:nodejs][:npm][:install_method] = "source"

default[:nodejs][:install_repo] = false
