default[:artifactory][:version] = "4.6.0"
default[:artifactory][:download_dir] = "/opt/"
if node[:platform] == 'ubuntu'
	default[:artifactory][:name] = "artifactory-oss-#{node[:artifactory][:version]}"
	default[:artifactory][:zip_name] = "jfrog-artifactory-oss-#{node[:artifactory][:version]}.zip"
	default[:artifactory][:url] = "https://bintray.com/artifact/download/jfrog/artifactory/#{node[:artifactory][:zip_name]}"
elsif node[:platform_family] == 'rhel'
	default[:artifactory][:zip_name] = "jfrog-artifactory-oss-#{node[:artifactory][:version]}.rpm"
	default[:artifactory][:url] = "https://bintray.com/artifact/download/jfrog/artifactory-rpms/#{node[:artifactory][:zip_name]}"
end
	
