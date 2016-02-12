name             'deploy_iis'
maintainer       'Relevance Lab Pvt Ltd'
maintainer_email 'devops@relevancelab.com'
license          'All rights reserved'
description      'Installs/Configures deploy_iis'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

depends 'iis'

attribute 'deploy_iis/docroot',
  :display_name => "IIS Docroot",
  :description => "Please specify IIS Docroot",
  :default => 'C:\inetpub\wwwroot'
  
attribute 'deploy_iis/applink',
  :display_name => "Artifact URL",
  :description => "Artifact URL",
  :default => 'https://github.com/RLOpenCatalyst/automationlibrary/raw/master/DemoWebSite1.zip'
