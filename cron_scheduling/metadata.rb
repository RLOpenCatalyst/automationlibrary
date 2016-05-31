name             'cron_scheduling'
maintainer       'Relevance Lab pvt ltd.'
maintainer_email 'jyoti.singh@relevancelab.com'
license          'All rights reserved'
description      'Installs/Configures cron_scheduling'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'


attribute 'cron_scheduling/catalyst/username',
  :display_name => "Catalyst User Name",
  :description => "Catalyst User Name",
  :default => nil

attribute 'cron_scheduling/catalyst/password',
  :display_name => "Catalyst Password",
  :description => "Catalyst Password",
  :default => nil

attribute 'cron_scheduling/catalyst/url',
  :display_name => "Catalyst URL",
  :description => "Catalyst URL",
  :default => nil
  

  attribute 'cron_scheduling/role',
  :display_name => "Role Name",
  :description => "Please add role name",
  :default => nil

attribute 'cron_scheduling/start/hour',
  :display_name => "Start time- Hour",
  :description => "cron_scheduling hour in 24 hrs format",
  :default => nil

attribute 'cron_scheduling/start/minute',
  :display_name => "Start time- minute",
  :description => "add minutes",
  :default => nil



 attribute 'cron_scheduling/stop/hour',
  :display_name => "Stop time- Hour",
  :description => "cron_scheduling hour in 24 hrs format",
  :default => nil

attribute 'cron_scheduling/stop/minute',
  :display_name => "Stop time- minute",
  :description => "add minutes",
  :default => nil

