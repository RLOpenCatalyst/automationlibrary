name             'deploy_dotNet'
maintainer       'Relevance Lab Pvt Ltd'
maintainer_email 'dsihag@chef.io'
license          'All rights reserved'
description      'Installs/Configures deploy_iis'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.5'

depends  	'iis'
depends 	'git'
depends		'windows'

supports	'windows'

