# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'cancan_unit_test/version'

Gem::Specification.new do |gem|
  gem.name          = "cancan-unit-test"
  gem.version       = CancanUnitTest::VERSION
  gem.authors       = ["Todd Mohney, Rasheed Abdul-Aziz"]
  gem.email         = ["zephyr-dev@googlegroups.com"]
  gem.description   = %q{Unit test helpers for CanCan}
  gem.summary       = %q{Unit test helpers for CanCan}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.test_files    = gem.files.grep(%r{^(integraton|spec)/})
  gem.require_paths = ["lib"]

  # Expected by the gem when installed
  gem.add_dependency "cancan"
  gem.add_dependency "activesupport"

  # expected for running the gem dev env
  gem.add_development_dependency "rake"
  gem.add_development_dependency "pry"
  gem.add_development_dependency "rspec"
  gem.add_development_dependency "rspec-rails"
  gem.add_development_dependency "sqlite3"
  gem.add_development_dependency "railties"
  gem.add_development_dependency "rspec-mocks-extensions"
end
