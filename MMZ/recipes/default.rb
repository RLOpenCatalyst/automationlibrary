#
# Cookbook Name:: MMZ
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
    package "marathon"

    all_mmz_servers = search("node","role:MMZ")
    ZIPs = ""
	MIPs = ""
	i = 1
    all_mmz_servers.each do |mmz_node|
       zmember = "server." + i.to_s + "=" + mmz_node["ipaddress"] + ":2888:3888\n"
	   mesosmember = mmz_node["ipaddress"] + ":2181,"
	   ZIPs = ZIPs + zmember
	   MIPs = MIPs + mesosmember
	   i = i + 1
    end
	MIPs = MIPs.chomp(',')
	template "/etc/zookeeper/conf/zoo.cfg" do
	   source "zoo.cfg.erb"
	   variables ({
	   :mmz_ips => ZIPs}) 
	end
	template "/etc/mesos/zk" do
	   source "zk.erb"
	   variables ({
	   :mesosIPs => MIPs + "/mesos"}) 
	end
    template "/etc/mesos-master/quorum" do
	   source "quorum.erb"
	   variables ({
	   :quorum => i.to_i/2}) 
	end
	template "/etc/mesos-master/cluster" do
	   source "cluster.erb"
	   variables ({
	   :clustername => "MMZCluster"}) 
	end
	template "/etc/mesos-master/hostname" do
	   source "hostname.erb"
	   variables ({
	   :hostname => "#{node["ipaddress"]}"}) 
	end
	template "/etc/mesos-master/ip" do
	   source "ip.erb"
	   variables ({
	   :ipaddress => "#{node["ipaddress"]}"}) 
	end

	directory "/etc/marathon"
	directory "/etc/marathon/conf"
	template "/etc/marathon/conf/hostname" do
	   source "hostname.erb"
	   variables ({
	   :hostname => "#{node["ipaddress"]}"}) 
	end
	template "/etc/marathon/conf/zk" do
	   source "zk.erb"
	   variables ({
	   :mesosIPs => MIPs + "/marathon"}) 
	end
	template "/etc/marathon/conf/master" do
	   source "zk.erb"
	   variables ({
	   :mesosIPs => MIPs + "/mesos"}) 
	end

	service "zookeeper" do
	        action [:enable, :start]
	end
		
	bash "myid" do
      code <<-EOH
        arr=$(cat "/etc/zookeeper/conf/zoo.cfg" | grep "#{node[ipaddress]}" | tr ".=" "\n")
        idval=$(echo $arr | awk '{print $2}')
        echo $idval > "/etc/zookeeper/conf/myid"
		if ["$idval" != 1];
		   then
		       service mesos-master stop
	           sleep 60
        fi	
		EOH
    end
 
	service "mesos-slave" do
	   action [:stop]
	end
	
	service "mesos-master" do
	   action [:start]
	end
	service "marathon" do
	   action [:enable, :start]
	end


 

