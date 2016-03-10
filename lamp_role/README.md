# Description

# LAMP cookbook

[![Build Status](https://travis-ci.org/fabn/chef-lamp_role.svg)](https://travis-ci.org/fabn/chef-lamp_role)

[Role wrapper cookbook](http://www.getchef.com/blog/2013/12/03/doing-wrapper-cookbooks-right/) for LAMP stack.

This cookbook provides a full LAMP stack on Ubuntu LTS platform, just include default recipe to get a full LAMP stack.

Currently tested with the following setup:

* Chef: 11.10.4
* Ubuntu 14.04

This cookbook (current version) will not work with apache 2.2 and ubuntu < 13.10.

# Requirements

## Platform:

* Ubuntu (>= 13.10)

## Cookbooks:

* mysql_role (~> 0.1)
* apache2 (>= 2.0.0)
* php
* ssl

# Attributes

* `node[:apache][:default_modules]` -  Defaults to `"%w("`.
* `node[:apache][:prefork][:startservers]` -  Defaults to `"8"`.
* `node[:apache][:prefork][:minspareservers]` -  Defaults to `"8"`.
* `node[:apache][:prefork][:maxspareservers]` -  Defaults to `"16"`.
* `node[:apache][:prefork][:serverlimit]` -  Defaults to `"200"`.
* `node[:apache][:prefork][:maxclients]` -  Defaults to `"200"`.
* `node[:apache][:prefork][:maxrequestsperchild]` -  Defaults to `"10_000"`.
* `node[:apache][:override_default_site]` - Whether to override apache2 default site with a deny all configuration. Defaults to `"true"`.
* `node[:lamp][:www_browser]` - Name of a package which provides www-browser in Ubuntu. Defaults to `"w3m"`.
* `node[:lamp][:php_modules]` - Default php modules installed by `php_modules` recipe. Defaults to `"%w(mysql gd apc curl)"`.
* `node[:lamp][:apc][:memory]` - APC memory size. Defaults to `"128M"`.
* `node[:lamp][:apc][:slam_defense]` - APC slam defense suppression. Defaults to `"false"`.
* `node[:php_applications][:applications_bag]` - Reserved for future usage. Defaults to `"php_applications"`.
* `node[:php_applications][:apps_path]` - Base path where to put php applications. Defaults to `"node[:apache][:docroot_dir]"`.
* `node[:php_applications][:user]` - Default owner for php applications. Defaults to `"node[:apache][:user]"`.
* `node[:php_applications][:group]` - Default group for php applications. Defaults to `"node[:apache][:group]"`.
* `node[:php_applications][:mysql_admin_credentials][:host]` - Database host where to create db users. Defaults to `"localhost"`.
* `node[:php_applications][:mysql_admin_credentials][:username]` - Administrative database user for creating db users. Defaults to `"root"`.
* `node[:php_applications][:mysql_admin_credentials][:password]` - Administrative database password for creating db users. Defaults to `"node[:mysql][:server_root_password]"`.

# Recipes

* [lamp_role::apache2](#lamp_roleapache2) - Installs Apache2 webserver and configures its default host.
* [lamp_role::default](#lamp_roledefault) - Installs Apache2, PHP and MySQL on the target host.
* [lamp_role::php](#lamp_rolephp) - Simple wrapper for opscode php cookbook.
* [lamp_role::php_modules](#lamp_rolephp_modules) - Attribute driven wrapper for opscode php::module_xxx recipes.

## lamp_role::apache2

Installs Apache2 webserver and configures its default host.

## lamp_role::default

Installs Apache2, PHP and MySQL on the target host.

Apache default virtual host is overridden with [this template](templates/default/default-site.erb)
  i.e. is configured to respond with '404 Not found' on every request.

Apache status is configured to respond on virtual host only,
this can be useful in order to setup monit with apache protocol.  

PHP is installed with modules given in attributes and prepared for MySQL integration.  

MySQL is configured using [this role cookbook](https://github.com/fabn/chef-mysql_role) 


## lamp_role::php

Simple wrapper for opscode php cookbook.

## lamp_role::php_modules

Attribute driven wrapper for opscode php::module_xxx recipes.

# Definitions

* [php_application](#php_application)

## php_application


### Parameters

- enable: . Defaults to: true
# Definitions

## php\_application

This definition can be used to setup a virtual host for a php application. It accepts some parameters to configure
the application, here are the accepted configuration options and their default values:

* `basedir` - This will be the path where the application is stored. Default `#{node[:php_applications][:apps_path]}/#{application_name}`
* `owner` - Application folder owner. Default `node[:php_applications][:user]`
* `group` - Application folder group. Application folder is configured with mode 2775, in this way any content created inside
 the folder can be shared with all members of this group. Default `node[:php_applications][:group]`
* `canonical_hostname` - If given and not false the application a [rewrite rule](templates/default/apache_vhost.conf.erb#L45)
 is added to vhost configuration to redirect all requests made with non canonical hostname to the same path but with
 canonical hostname, useful for SEO. Default `application_name`
* `aliases` - An array of aliases for the given virtual host. Default `[]`
* `capistrano` - Prepare the virtual host for capistrano support, i.e. Point Document Root to `"#{basedir}/current"`. Default `false`
* `zend_framework` - Prepare the virtual host for zend framework support, i.e. Point Document Root to `"#{basedir}/public"`. Default `false`
* `mysql` - If hash can be used to create local users for the application (see [this example](recipes/_integration.rb#L37). Default `false`
* `users` - Additional system users to append to application group. Default `[]`
* `document_root` - Used to override application document root in virtual host configuration. Default `nil`
* `ssl` - SSL support for virtual host, need some documentation. Default `false`

Additional parameters can be given to configure php directives in virtual host file. They are hashes of php flags or values

* `php_values` - PHP values in apache config. Default `{}`
* `php_admin_values` - PHP admin values in apache config. Default `{}`
* `php_flags` - PHP flags in apache config. Default `{}`
* `php_admin_flags` - PHP admin flags in apache config. Default `{}`

A minimal example of `php_application` definition is the following

```ruby
# Plain php site with some features on
php_application 'php.example.com' do
 application_config aliases: ['php2.example.com'], users: %w(vagrant)
end
```

Full usage of this definition is shown in [this recipe](recipes/_integration.rb) and its
 [serverspec](test/integration/default/serverspec/php_applications_spec.rb)


# License and Maintainer

Maintainer:: Fabio Napoleoni (<f.napoleoni@gmail.com>)

License:: Apache 2.0
