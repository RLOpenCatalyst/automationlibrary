puts node[:artifactory][:download_dir]
puts node[:artifactory][:zip_name]
puts node[:artifactory][:url]

execute "silent execution" do
	command 'echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections'
end

apt_repository 'webupd8team-trusty' do
		uri 'ppa:webupd8team/java'
		distribution node[:lsb][:codename]
end

execute "apt-get update"

apt_package "oracle-java8-installer"

if Dir.exists?("/usr/lib/jvm/java-8-oracle")
    compile_flags = 'JAVA_HOME="/usr/lib/jvm/java-8-oracle"'
end

ruby_block 'set-env-java-home' do
  block do
    ENV['JAVA_HOME'] = compile_flags
  end
  not_if { ENV['JAVA_HOME'] == compile_flags }
end

ruby_block 'Set JAVA_HOME in /etc/environment' do
    block do
      file = Chef::Util::FileEdit.new('/etc/environment')
      file.insert_line_if_no_match(/^JAVA_HOME=/, compile_flags)
      file.write_file
    end
end

install_path = "#{node[:artifactory][:download_dir]}#{node[:artifactory][:zip_name]}"
puts install_path

bash "downloading of artifactory" do
	cwd node[:artifactory][:download_dir]
	code <<-EOH
	wget #{node[:artifactory][:url]}
	sudo apt-get install unzip
	unzip #{node[:artifactory][:zip_name]}
	cd #{node[:artifactory][:name]}/bin/
	sudo ./installService.sh
	EOH
	not_if { ::File.exists?(install_path) }
end

ruby_block 'Set JAVA_HOME in /etc/opt/jfrog/artifactory' do
    block do
      file = Chef::Util::FileEdit.new('/etc/opt/jfrog/artifactory/default')
      file.insert_line_if_no_match(/^JAVA_HOME=/, 'export JAVA_HOME=/usr/lib/jvm/java-8-oracle')
      file.write_file
    end
end

execute "starting artifactory" do
	command "sudo /etc/init.d/artifactory start"
end