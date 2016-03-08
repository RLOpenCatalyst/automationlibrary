name             'vagrant'
maintainer       'Joshua Timberman'
maintainer_email 'cookbooks@housepub.org'
license          'Apache 2.0'
description      'Installs Vagrant and provides a vagrant_plugin LWRP for installing Vagrant plugins.'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.5.0'

source_url 'https://github.com/jtimberman/vagrant-cookbook' if respond_to?(:source_url)
issues_url 'https://github.com/jtimberman/vagrant-cookbook/issues' if respond_to?(:issues_url)

supports 'debian', '>= 6.0'
supports 'ubuntu', '>= 12.04'
supports 'redhat', '>= 6.3'
supports 'centos', '>= 6.4'
supports 'windows'
supports 'mac_os_x'

depends 'dmg', '>= 2.2.2'
depends 'windows', '~> 1.38'