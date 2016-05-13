#
# Cookbook Name:: sensu
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
case node['platform']
when 'debian', 'ubuntu'
  include_recipe 'ashish_sensu::debian'
when 'redhat', 'centos' , 'fedora'
  include_recipe 'ashish_sensu::centos'
end


["rabbitmq-server","uchiwa",].each do |pkg|
    package pkg do
        action :install
    end


    service pkg do
       supports :restart => true,  :reload => true
       action [ :enable, :start ]
    end
end

case node['platform']
when 'debian', 'ubuntu'  
  ["sensu"].each do|pkg|
      package pkg do
         action :install
       end
     end
when 'redhat', 'centos' , 'fedora'
  ["redis","sensu"].each do|pkg|
      package pkg do
        action :install
      end  
    end
end
service 'redis' do
  supports :restart => true,  :reload => true
       action [ :enable, :start ]
     end



service 'sensu-server' do
  supports :restart => true,  :reload => true
       action [ :enable, :start ]
     end

execute 'adduser' do 
command 'sudo rabbitmqctl add_vhost /sensu; sudo rabbitmqctl add_user sensu secret; sudo rabbitmqctl set_permissions -p /sensu sensu ".*" ".*" ".*"'
not_if 'rabbitmqctl list_users | grep sensu'
end
 

template '/etc/sensu/config.json' do
  source 'config.json.erb'
  mode '0755'
   variables(
     :hostname => "localhost"
   )
   notifies :restart, 'service[sensu-server]',:immediately
   notifies :restart, 'service[sensu-api]',:immediately
end

service "sensu-server" do
       supports :restart => true,  :reload => true
       action :nothing
        
    end


["sensu-server","sensu-api"].each do |server|

    service server do
       supports :restart => true,  :reload => true
       action [ :enable, :restart ]
    end
end