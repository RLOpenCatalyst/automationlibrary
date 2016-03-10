#
# Cookbook Name:: lamp_role
# Recipe:: default
#
# Copyright (C) 2014 Fabio Napoleoni
# 
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# 
#    http://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

=begin
#<
Installs Apache2, PHP and MySQL on the target host.

Apache default virtual host is overridden with [this template](templates/default/default-site.erb)
  i.e. is configured to respond with '404 Not found' on every request.

Apache status is configured to respond on virtual host only,
this can be useful in order to setup monit with apache protocol.  

PHP is installed with modules given in attributes and prepared for MySQL integration.  

MySQL is configured using [this role cookbook](https://github.com/fabn/chef-mysql_role) 

#>
=end

# This is coming from other cookbook
include_recipe 'mysql::server'
# Install and tune apache2
include_recipe 'lamp_role::apache2'
# Install php and usual modules
include_recipe 'lamp_role::php'
include_recipe 'lamp_role::php_modules'
