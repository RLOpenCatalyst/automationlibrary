# User
default['liferay']['user'] = "liferay"
default['liferay']['group'] = "liferay"

# Install
default['liferay']['install_directory'] = "/opt"

# Liferay Download
default['liferay']['download_directory'] = Chef::Config[:file_cache_path]
default['liferay']['download_url'] = "http://downloads.sourceforge.net/project/lportal/Liferay%20Portal/6.1.1%20GA2/liferay-portal-tomcat-6.1.1-ce-ga2-20120731132656558.zip"


# Tomcat
default['liferay']['tomcat']['server_xml']['port'] = "8001"

# DB Config
default['liferay']['tomcat']['root_xml']['jndi_resource']['name'] = "jdbc/lportal"
default['liferay']['tomcat']['root_xml']['jndi_resource']['auth'] = "Container"
default['liferay']['tomcat']['root_xml']['jndi_resource']['type'] = "javax.sql.DataSource"
default['liferay']['tomcat']['root_xml']['jndi_resource']['username'] = "liferay_user"
default['liferay']['tomcat']['root_xml']['jndi_resource']['password'] = "l1f3r4y"
default['liferay']['tomcat']['root_xml']['jndi_resource']['driverClassName'] = "org.postgresql.Driver"
default['liferay']['tomcat']['root_xml']['jndi_resource']['url'] = "jdbc:postgresql://localhost:5432/lportal"

