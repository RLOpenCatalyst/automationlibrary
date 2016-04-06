name             'app_data_handler'
maintainer       'Relevance Lab INC'
maintainer_email 'mrigesh.priyadarshi@relevancelab.com'
license          'All rights reserved'
description      'Installs/Configures app_data_handler'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.9'

depends	'chef_handler'
depends 'build-essential'

recipe "app_data_handler", "Includes the RedHat recipe or any other recipe on the basis of Operating System Platform."
recipe "app_data_handler::linux", "Configure Catalyst Attribute Handler for Chef client Run on RedHat, CentOS and  Ubuntu machines"
recipe "app_data_handler::windows", "Configure Catalyst Attribute Handler for Chef client Run on Windows machines"


%w{ redhat centos ubuntu windows}.each { |os| supports os }

attribute 'app_data_handler/app/applicationName',
  :description => 'Application Name',
  :choice => [],
  :type => 'string',
  :required => 'recommended',
  :recipes => [],
  :default => 'Mrigesh'

attribute 'app_data_handler/app/applicationVersionInput',
  :description => 'Application Version',
  :choice => [],
  :type => 'string',
  :required => 'recommended',
  :recipes => [],
  :default => '0.0.7'

attribute 'app_data_handler/catalystCallbackUrl',
  :description => 'Rest Call Back URL',
  :choice => [],
  :type => 'string',
  :required => 'recommended',
  :recipes => [],
  :default => 'http://d4d.rlcatalyst.com/app/deploy'

attribute 'app_data_handler/app/applicationVersion',
  :description => 'Application Version',
  :choice => [],
  :type => 'string',
  :required => 'recommended',
  :recipes => [],
  :default => 'NA'
  
  attribute 'app_data_handler/user',
  :description => 'User Name for the platform',
  :choice => [],
  :type => 'string',
  :required => 'recommended',
  :recipes => []
  #:default => 'ubuntu'

#'http://supercatalyst.relevancelab.com/app/deploy'
