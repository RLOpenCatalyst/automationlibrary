# check the run list for multi_war
# user = %x(cut -d: -f1 /etc/passwd | grep '^tomcat')
# if user is not empty, call single node
# else call 2 nodes
war_recipe = search(:node, %Q{run_list:*multitier_war* AND run_list:*multitier_db* }  )

user = %x(cut -d: -f1 /etc/passwd | grep '^tomcat')

if !war_recipe.empty? || !user.empty?
	# single node
	include_recipe "3tier_dbg_db::db_config"
	include_recipe "3tier_dbg_db::db_deploy"
else  # multi nodes
	include_recipe "3tier_dbg_db::db_config"
	include_recipe "3tier_dbg_db::create_dbg"
	include_recipe "3tier_dbg_db::db_deploy"
	include_recipe "3tier_dbg_db::send_report"

end
