tomcat_version = node['tomcat-all-rl']['version']
major_version = tomcat_version[0]

tomcat_home = node['tomcat-all-rl']['tomcat_home']


stop=`ps -ef | grep #{tomcat_home}`

if 	stop == ""

execute "Stop Tomcat#{major_version} " do

	command "cd #{tomcat_home}/bin/
			 sudo ./shutdown.sh"
action :run
ignore_failure true
end

end

# service "tomcat#{major_version}" do
#   action :stop
# end
