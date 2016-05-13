default['mesos']['init']       = case node['platform']
                                 when 'debian'
                                   node['platform_version'].to_i >= 8 ? 'systemd' : 'sysvinit_debian'
                                 when 'ubuntu'
                                   node['platform_version'].to_f >= 15.04 ? 'systemd' : 'upstart'
                                 when 'redhat', 'centos', 'scientific' # ~FC024
                                   node['platform_version'].to_i >= 7 ? 'systemd' : 'upstart'
                                 else 'upstart'
                                 end
default['java']['jdk_version'] = '8'