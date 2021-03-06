def include_dummy_app
  require File.expand_path("../../integration/fixtures/dummy/config/environment.rb",  __FILE__)
  require 'rspec/rails'
  require 'rspec/autorun'
  require 'bundler'
  require 'rails/test_help'
end

def include_dummy_app_post_dependencies
  require 'spec_helper'
  Dir[Rails.root.join("integration/support/**/*.rb")].each { |f| require f }
end


ENV["RAILS_ENV"] = "test"

include_dummy_app
include_dummy_app_post_dependencies

Rails.backtrace_cleaner.remove_silencers!

RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/integration/fixtures"

  config.use_transactional_fixtures = true

  config.infer_base_class_for_anonymous_controllers = false

  config.order = "random"

  config.include RSpec::Rails::ControllerExampleGroup, :type => :controller, :example_group => {
    :file_path => config.escaped_path(%w[integration controllers])
  }

  config.include CancanUnitTest::Mocks
end
