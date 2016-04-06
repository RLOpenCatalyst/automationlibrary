default['jenkin']['java']['jenkinPackage'] = 'jenkins'
default['jenkin']['apt_repokey'] = 'https://jenkins-ci.org/debian/jenkins-ci.org.key'
default['jenkin']['apt_repourl'] = 'http://pkg.jenkins-ci.org/debian-stable/ binary/'
default['jenkin']['install'] = 'jenkins'
default['jenkin']['java']['type'] = 'openjdk'
default['jenkin']['java']['version'] = '7'
default['jenkin']['java']['packagename'] = "#{node['jenkin']['java']['type']}-#{node['jenkin']['java']['version']}-jdk"
default['jenkin']['apt_get_repoloc'] = '/etc/apt/sources.list.d'
default['jenkin']['apt_repofile'] = 'jenkins.list'
default['jenkin']['user'] = 'root'
default['jenkin']['group'] = 'root'
default['jenkin']['yum_repoloc'] = '/etc/yum.repos.d'
default['jenkin']['yum_repofile'] = 'jenkins.repo'
default['jenkin']['yum_repourl'] = 'http://pkg.jenkins-ci.org/redhat-stable'
default['jenkin']['yum_repokey'] = 'https://jenkins-ci.org/redhat/jenkins-ci.org.key'
default['jenkin']['yum_java'] = 'java'
default['jenkin']['yum_java_version'] = '1.7.0'
default['jenkin']['yum_java_packagename'] = "#{node['jenkin']['yum_java']}-#{node['jenkin']['yum_java_version']}-#{node['jenkin']['java']['type']}.x86_64"
#java-1.7.0-openjdk.x86_64
#/etc/yum.repos.d/jenkins.repo
#openjdk-7-jre-headless
