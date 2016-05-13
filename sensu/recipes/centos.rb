yum_package 'wget' do
	action :install
	not_if 'rpm -qa | grep wget'
end

execute 'configure erlang' do
	command 'rpm -Uvh http://dl.fedoraproject.org/pub/epel/5/i386/epel-release-5-4.noarch.rpm;
wget -O /etc/yum.repos.d/epel-erlang.repo http://repos.fedorapeople.org/repos/peter/erlang/epel-erlang.repo ; rpm -Uvh http://dl.fedoraproject.org/pub/epel/6/i386/epel-release-6-8.noarch.rpm
'
not_if 'rpm -qa | grep epel'
end

yum_package 'erlang' do
	action :install
	not_if 'rpm -qa | grep erlang'
end

execute 'install rabbitmq' do
	command 'rpm --import http://www.rabbitmq.com/rabbitmq-signing-key-public.asc ;
rpm -Uvh http://www.rabbitmq.com/releases/rabbitmq-server/v3.1.4/rabbitmq-server-3.1.4-1.noarch.rpm'
not_if 'rpm -qa | grep rabbitmq'
end

template '/etc/yum.repos.d/sensu.repo' do
	source 'sensu.repo.erb'
	owner 'root'
	group 'root'
end
