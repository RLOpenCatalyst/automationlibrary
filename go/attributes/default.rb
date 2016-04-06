default['go']['version'] = '1.6'
default['go']['filename'] = "go#{node['go']['version']}.linux-amd64.tar.gz"
default['go']['url'] = "https://storage.googleapis.com/golang/#{node['go']['filename']}"
