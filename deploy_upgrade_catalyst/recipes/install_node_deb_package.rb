execute 'curl -sL https://deb.nodesource.com/setup_4.x | sudo -E bash -'

case node["platform_family"]
when "debian"
  execute "apt-get update -y"
when "rhel"
  execute "yum update -y"
end

package 'nodejs'

