#
# Cookbook Name:: MMZ_slave
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

include_recipe 'java'

    bash "add_key_repo" do
        code <<-EOH
	        sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv E56151BF
	        echo "deb http://repos.mesosphere.com/$(lsb_release -is | tr '[:upper:]' '[:lower:]') $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/mesosphere.list 
		    sudo apt-get -y update
		EOH
    end
	package "mesos" 

 	service "zookeeper" do
	    action [:enable, :start]
	end
	   
all_mmz_servers = search("node","role:mmz_cloud")
    ZIPs = ""
	MIPs = ""
	i = 1
    all_mmz_servers.each do |mmz_node|
       zmember = "server." + i.to_s + "=" + mmz_node['cloud']['local_ipv4'] + ":2888:3888\n"
	   mesosmember = mmz_node['cloud']['local_ipv4'] + ":2181,"
	   ZIPs = ZIPs + zmember
	   MIPs = MIPs + mesosmember
	   i = i + 1
    end
	MIPs = MIPs.chomp(',')

	template "/etc/mesos/zk" do
	   source "zk.erb"
	   variables ({
	   :mesosIPs => MIPs + "/mesos"}) 
	end


	template "/etc/mesos-slave/hostname" do
	   source "hostname.erb"
	   variables ({
	   :hostname => "#{node['cloud']['local_ipv4']}"}) 
	end
	template "/etc/mesos-slave/ip" do
	   source "ip.erb"
	   variables ({
	   :ipaddress => "#{node['cloud']['local_ipv4']}"}) 
	end

	
	service "mesos-slave" do
	   action [:enable, :start]
	end
	
	service "mesos-master" do
	   action [:stop]
	end


 

