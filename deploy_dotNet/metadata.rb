name             'deploy_dotnet'
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
  
attribute 'deploy_dotnet/gitRepo',
  :display_name => "Git repo",
  :description => "git file of the source code repo",
  :default => 'git://github.com/RLIndia/cms.git'
