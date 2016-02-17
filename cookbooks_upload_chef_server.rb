def berks_upload(home_dir)
	knife_file = File.join(home_dir,'.chef/knife.rb')
	if File.exist?(knife_file)
		folders_list = Dir.entries(home_dir).sort!
		puts folders_list
		folders_list.each do |file|
			if Dir.exist?(File.join(home_dir,file))
				puts file
				folder = File.join(home_dir,file)
				Dir.chdir(folder)
				`berks install`
				`berks upload`
			else 
				next
			end	
		end
	end
end

berks_upload('/home/sraddhananad/chef_workspace/automationlibrary')