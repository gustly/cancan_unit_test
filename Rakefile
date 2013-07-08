require 'bundler/gem_tasks'
require 'rspec/core/rake_task'
require 'rails'
require 'rspec-rails'

RSpec::Core::RakeTask.new(:spec)
RSpec::Core::RakeTask.new(:integration) do |integration_task|
  integration_task.pattern = "integration/**/*_spec.rb"
end

task :default => [:spec, :integration]

APP_RAKEFILE = File.expand_path("../integration/fixtures/dummy/Rakefile", __FILE__)
load 'rails/tasks/engine.rake'

