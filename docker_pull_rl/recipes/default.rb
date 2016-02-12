

docker_service 'default' do
  action [:create, :start]
end


# # logs into the docker hub and and pull the specific image 
execute "pull private repo" do
  if !node[:docker_pull_rl][:image].nil? then
    command "docker login -u #{node[:docker_pull_rl][:user_id]} -p #{node[:docker_pull_rl][:password]} -e #{node[:docker_pull_rl][:email]} && docker pull #{node[:docker_pull_rl][:image]}"
  else 
    command "docker login -u #{node[:docker_pull_rl][:user_id]} -p #{node[:docker_pull_rl][:password]} -e #{node[:docker_pull_rl][:email]}"
  end    
end 
