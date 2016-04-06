=begin
# get the scripts from url
# if ext == zip 
	extract and run the master script
elsif ext == sql
	run the script
else
	through error.
end
write the log into the
=end
url = node[:rlcatalyst][:dbpkgurl]

app_arch_file = url.split("/").last

arch_extn = app_arch_file[-3..-1]

if arch_extn =="zip"
	
	execute "rm -f *.sql" do 
		cwd "/opt"
	end  
# archive the earlier zip file and proceed.

	remote_file "/opt/db_package.zip" do
		source url
		mode "0644"
		action :create
	end

	ruby_block "sleep_1" do
  		block do
			sleep (5)
		end
	end		
	package 'unzip'

	execute "unzip /opt/db_package.zip" do
	   cwd "/opt"
	end


	ruby_block "sleep_2" do
  		block do
			sleep (5)
		end
	end

	execute "chmod 644 *.sql" do 
		cwd "/opt"
	end

elsif arch_extn =="sql"

	remote_file "/opt/default.sql" do
		source url
		mode "0644"
	end

	ruby_block "sleep_3" do
  		block do
			sleep (5)
		end
	end
else
	puts "provide the url containing sql or zip file"
end

	ruby_block "modifying MySQL2 client" do
  		block do
    		Mysql2::Client.default_query_options[:connect_flags] |= Mysql2::Client::MULTI_STATEMENTS
  		end
  		action :run
	end

	mysql_connection_info = {
	  :host     => 'localhost',
	  :username => node[:multitier][:database_user],
	  :password => node[:multitier][:database_password],
	  :socket => "/var/run/mysql-5.5/mysqld.sock"
	}

	mysql_database "execute sqls" do
		database_name node[:multitier][:database_name]
	  connection mysql_connection_info
	  sql { ::File.open('/opt/default.sql').read }
	  action :query
	end


