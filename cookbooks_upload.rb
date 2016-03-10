def berks_upload(home_dir)
	user = %x(knife user list)
	puts "user: #{user}"
	if !user.empty?
		folders_list = Dir.entries(home_dir).sort!
		puts folders_list
		folders_list.each do |file|
			if Dir.exist?(File.join(home_dir,file))
				puts file
				folder = File.join(home_dir,file)
				Dir.chdir(folder)
				`berks install`
				`berks upload --no-ssl-verify --force`
			else 
				next
			end	
		end
	else
		puts "Please check the presence of pem file and knife.rb. If the files are missing or invalid, download from chef server"	
	end
end

berks_upload(File.expand_path File.dirname(__FILE__))
