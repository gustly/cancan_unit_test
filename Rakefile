require 'bundler/gem_tasks'
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec)
RSpec::Core::RakeTask.new(:spec_integration) do |task|
  task.pattern = "integration/controllers/*_spec.rb"
end

task :default => [:spec, :spec_integration]


