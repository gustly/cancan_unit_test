module CancanUnitTest
  module Mocks

    def stub_load_and_authorize_singleton_resource(model, options={}, &block)
      controller._add_cancan_unit_test_stub(:load_and_authorize_resource, :singleton, model, options, &block)
    end

    def stub_load_and_authorize_collection_resource(model, options={}, &block)
      controller._add_cancan_unit_test_stub(:load_and_authorize_resource, :collection, model, options, &block)
    end

    def stub_load_singleton_resource(model, options={}, &block)
      controller._add_cancan_unit_test_stub(:load_resource, :singleton, model, options, &block)
    end

    RSpec.configure do |config|
      config.before(:each, cancan_unit_test_warning: true) do
        CancanUnitTest::CanCan::ControllerResource.show_warnings = true
      end

      config.after(:each, cancan_unit_test_warning: true) do
        CancanUnitTest::CanCan::ControllerResource.show_warnings = false
      end
    end

  end
end
