require 'rspec/core/rake_task'
require 'kitchen/rake_tasks'

# Rspec and ChefSpec
desc "Run ChefSpec examples"
RSpec::Core::RakeTask.new(:spec)

# Kitchen integration tests
Kitchen::RakeTasks.new

# Default task
task default: [:spec, 'kitchen:all']
