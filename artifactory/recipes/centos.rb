execute "update" do
	command "yum -y update"
end

bash "install of java" do
	cwd node[:artifactory][:download_dir]
	code <<-EOH
	wget --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/8u60-b27/jdk-8u60-linux-x64.rpm"
	sudo yum localinstall -y /opt/jdk-8u60-linux-x64.rpm
	EOH
	not_if { ::File.exists?('/opt/jdk-8u60-linux-x64.rpm') }
end

if Dir.exists?("/usr/java/jdk1.8.0_60")
    compile_flags = 'JAVA_HOME="/usr/java/jdk1.8.0_60"'
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
	sudo yum localinstall -y #{node[:artifactory][:zip_name]}
	EOH
	not_if { ::File.exists?('install_path') }
end

ruby_block 'Set JAVA_HOME in /etc/opt/jfrog/artifactory' do
    block do
      file = Chef::Util::FileEdit.new('/etc/opt/jfrog/artifactory/default')
      file.insert_line_if_no_match(/^JAVA_HOME=/, 'export JAVA_HOME=/usr/java/jdk1.8.0_60')
      file.write_file
    end
end

execute "starting artifactory" do
	command "sudo /etc/init.d/artifactory start"
end