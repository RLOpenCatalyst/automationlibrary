name             'deploy_liferay_app'
maintainer       'Relevance Lab INC'
maintainer_email 'YOUR_EMAIL'
license          'All rights reserved'
description      'Installs/Configures deploy_liferay_app'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'


depends "liferay"

attribute 'liferay/user',
  :display_name => "Liferay User",
  :description => "Please specify Liferay User",
  :default => 'liferay'

  attribute 'liferay/group',
  :display_name => "Liferay group",
  :description => "Please specify Liferay group",
  :default => 'liferay'

  attribute 'liferay/install_directory',
  :display_name => "Liferay install_directory",
  :description => "Please specify Liferay install_directory",
  :default => '/opt'

  attribute 'liferay/download_directory',
  :display_name => "Liferay download_directory",
  :description => "Please specify Liferay download_directory",
  :default => '/var/chef/cache'


  attribute 'liferay/download_url',
  :display_name => "Liferay download_url",
  :description => "Please specify Liferay download_url",
  :default => "http://downloads.sourceforge.net/project/lportal/Liferay%20Portal/6.1.1%20GA2/liferay-portal-tomcat-6.1.1-ce-ga2-20120731132656558.zip"


attribute 'liferay/tomcat/server_xml/port',
  :display_name => "Liferay tomcat server_xml port",
  :description => "Please specify Liferay tomcat server_xml port",
  :default => '8080'


  attribute 'liferay/tomcat/root_xml/jndi_resource/name',
  :display_name => "Liferay tomcat root_xml jndi_resource name",
  :description => "Please specify Liferay tomcat root_xml jndi_resource name",
  :default => 'jdbc/lportal'


  attribute 'liferay/tomcat/root_xml/jndi_resource/auth',
  :display_name => "Liferay tomcat root_xml jndi_resource auth",
  :description => "Please specify Liferay tomcat root_xml jndi_resource auth",
  :default => 'Container'


attribute 'liferay/tomcat/root_xml/jndi_resource/type',
  :display_name => "Liferay tomcat root_xml jndi_resource type",
  :description => "Please specify Liferay tomcat root_xml jndi_resource type",
  :default => 'javax.sql.DataSource'


  attribute 'liferay/tomcat/root_xml/jndi_resource/username',
  :display_name => "Liferay tomcat root_xml jndi_resource username",
  :description => "Please specify Liferay tomcat root_xml jndi_resource username",
  :default => 'liferay_user'


attribute 'liferay/tomcat/root_xml/jndi_resource/password',
  :display_name => "Liferay tomcat root_xml jndi_resource password",
  :description => "Please specify Liferay tomcat root_xml jndi_resource password",
  :default => 'l1f3r4y$'


attribute 'liferay/tomcat/root_xml/jndi_resource/driverClassName',
  :display_name => "Liferay tomcat root_xml jndi_resource driverClassName",
  :description => "Please specify Liferay tomcat root_xml jndi_resource driverClassName",
  :default => 'org.postgresql.Driver'


attribute 'liferay/tomcat/root_xml/jndi_resource/url',
  :display_name => "Liferay tomcat root_xml jndi_resource url",
  :description => "Please specify Liferay tomcat root_xml jndi_resource url",
  :default => 'jdbc:postgresql://localhost:5432/lportal'