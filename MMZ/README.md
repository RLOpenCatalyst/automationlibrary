# MMZ

Description
=========================
Application cookbook for installing the Apache Mesos, Marathon, zookeeper cluster.
Mesos provides efficient resource isolation and sharing across distributed applications, or frameworks.  
Marathon is an Apache Mesos framework for long-running services.
Zookeeper is a coordination and discovery service maintained by the Apache Software Foundation.


Dependencies from supermarket:
1) java - 8
2) build-essential

Platform
--------
Tested on

* Ubuntu 14.04
* Ubuntu 12.04

Recipes:
 ---default
    This will install all packages required for MMZ along with dependencies.

Role: 	
 ---MMZ 
    Role is used to get the ohai data like IP's of the mesos-master servers to elect one of them as a leader.
    Role helps in having the configuration done for zookeeper, mesos-master, mesos-slave.
    Example: 
    1) /etc/zookeeper/conf/zoo.cfg
 	2) /etc/mesos/conf/zk (either on master or slave)

Slave configuration needs mesos-master IP's for configuration, refer MMZ_slave cookbook for more info.

Usage :
    In ROLE defined above like "MMZ" include cookbook "MMZ" (or name of your cookbook).
    Assign role to the servers where you wish to have MMZ installation.
    Quorum value on each server depends on number of MMZ servers created, in cookbook calculation is done as per mesosphere document.
    Formula used : 
	quorum = ((number of nodes or servers)/2 ) + 1
    example : number of nodes = 3
   	quorum = 3/2 + 1 =  1.5 + 1 = 2.5, rounded down to 2.
	so quorum = 2.
	
	




