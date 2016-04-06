
execute 'java-list' do
  command "yum list java*"
  action :run
end

package node['jenkin']['yum_java_packagename']

#/etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat-stable/jenkins.repo
#['jenkin']['yum_repoloc']

template "#{node['jenkin']['yum_repoloc']}/#{node['jenkin']['yum_repofile']}" do
  source "#{node['jenkin']['yum_repofile']}.erb"
  owner node['jenkin']['user']
  group node['jenkin']['group']
  mode 0644
end


execute 'import-key' do
  command "rpm --import #{node['jenkin']['yum_repokey']}"
  action :run
end

package node['jenkin']['java']['jenkinPackage']

service node['jenkin']['java']['jenkinPackage'] do
  supports :status => true, :restart => true, :reload => true
  action [ :enable, :start ]
end
