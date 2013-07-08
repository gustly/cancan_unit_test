module CancanUnitTest
  module Mocks

    def stub_load_and_authorize_resource(model, options, &block)
      controller._cancan_stubs_add(:load_and_authorize_resource, model, options, block)
    end

  end
end
