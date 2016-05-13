# MMZ_slave

Description
=========================
Application cookbook for installing the Apache Mesos slave and automatically connected to master using roles.
Mesos provides efficient resource isolation and sharing across distributed applications, or frameworks.  


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
    This will install all packages required for Mesos along with dependencies.

Role: 	
 ---MMZ 
    Role is used to get the ohai data like IP's of the mesos-master servers to have them in configuration file of mesos-slave.
    Role helps in having the configuration done for zookeeper, mesos-master, mesos-slave.
    Example: 
    1) /etc/zookeeper/conf/zoo.cfg
 	2) /etc/mesos/conf/zk (either on master or slave)

Slave configuration needs mesos-master IP's for configuration.

Usage :
    In ROLE defined above like "MMZ" include cookbook "MMZ" (or name of your cookbook).
    Assign role to the servers where you wish to have MMZ installation.
	RUN MMZ_slave cookbook on any server which you wish to have connected to mesos-master cluster.

	
	




.

