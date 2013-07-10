module CancanUnitTest
  module Mocks

    def stub_load_and_authorize_resource(model, options={}, &block)
      controller._add_cancan_unit_test_stub(:load_and_authorize_resource, model, options, &block)
    end

  end
end
