==============
This cookbook installs redis,rabbitmq and sensu-server.

Usages
------
Simply include the 'sensu' recipe wherever you would like sensu-server installed such as a run list (`recipe[sensu]`) or a cookbook (`include_recipe 'sensu'`).

Requirements
-----

Chef 11+

### Platform

* Debian, Ubuntu
* CentOS, Red Hat, Fedora, Amazon.

Recipes
-----
###default
Include the default recipe in a run list to get sensu-server.


###centos
This recipe is for creating sensu-repo in Redhat flavoured OS for sensu-server instalation.

###debian
This recipe is for creating sensu-repo in debian flavoured OS for sensu-server instalation.
