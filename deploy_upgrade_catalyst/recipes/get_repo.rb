  version_path = Dir.glob("/opt/**/version.json").first
if version_path
  puts "Parent directory:: #{version_path}"
  app_home = version_path.split('opt/')[1].split("/")[0]
  node.default[:deploy_upgrade_catalyst][:app_home] = "/opt/#{app_home}/server"
  puts "$app_home_1:: #{node[:deploy_upgrade_catalyst][:app_home]}"
end