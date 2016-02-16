#
# Cookbook Name:: tomcat-all-rl
# Recipe:: restart
# Copyright 2015, Relevance Lab pvt ltd.
#
# All rights reserved - Do Not Redistribute
#

include_recipe "tomcat-all-rl::stop"
sleep (5)
include_recipe "tomcat-all-rl::start"