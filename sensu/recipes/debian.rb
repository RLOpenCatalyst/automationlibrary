execute 'create sensu repo' do
  command 'wget -q http://repositories.sensuapp.org/apt/pubkey.gpg -O- | sudo apt-key add -; echo "deb     http://repositories.sensuapp.org/apt sensu main" | sudo tee /etc/apt/sources.list.d/sensu.list; sudo apt-get update; sudo apt-get install sensu'
  not_if 'test -f /etc/init.d/sensu-server'
end
