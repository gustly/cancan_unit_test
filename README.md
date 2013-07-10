[![Build Status](https://travis-ci.org/gustly/cancan_unit_test.png?branch=master)](https://travis-ci.org/gustly/cancan_unit_test)

# CancanUnitTest

RSpec helpers to easily stub CanCan's load_and_authorize_resource methods for better controller unit testing

## Installation

Add this line to your application's Gemfile:

    gem 'cancan_unit_test'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install cancan_unit_test

## Usage

stub_load_and_authorize_resource(:model_name, options_hash)

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
