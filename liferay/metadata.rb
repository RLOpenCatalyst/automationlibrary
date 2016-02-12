name              "liferay"
maintainer        "Thirdwave, LLC"
maintainer_email  "adam.krone@thirdwavellc.com"
license           "Apache 2.0"
description       "Installs and configures Liferay"
version           "0.13.1"

depends "apt"
depends "unzip"
depends "imagemagick"
depends "java"
depends "database"
depends "postgresql"
depends "mysql"
depends "mysql_connector"

attribute 'liferay/postgresql/user',
  :display_name => "Liferay postgresql user",
  :description => "Please specify Liferay postgresql user",
  :default => 'liferay_user'


attribute 'liferay/postgresql/user_password',
  :display_name => "Liferay postgresql user_password",
  :description => "Please specify Liferay postgresql user_password",
  :default => 'l1f3r4y$'


attribute 'liferay/postgresql/database/default',
  :display_name => "Liferay postgresql database default",
  :description => "Please specify Liferay postgresql database default",
  :default => 'lportal'

attribute 'liferay/postgresql/database/dev',
  :display_name => "Liferay postgresql database dev",
  :description => "Please specify Liferay postgresql database dev",
  :default => 'liferay_dev'

attribute 'liferay/postgresql/database/staging',
  :display_name => "Liferay postgresql database staging",
  :description => "Please specify Liferay postgresql database staging",
  :default => 'liferay_stage'

attribute 'liferay/postgresql/database/production',
  :display_name => "Liferay postgresql database production",
  :description => "Please specify Liferay postgresql database production",
  :default => 'liferay_prod' 

  
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))