require 'rspec/core/rake_task'
require 'cucumber/rake/task'

RSpec::Core::RakeTask.new
Cucumber::Rake::Task.new

task :default => [:cucumber]

task :run do
  ruby 'lib/stake_sweeper.rb'
end
