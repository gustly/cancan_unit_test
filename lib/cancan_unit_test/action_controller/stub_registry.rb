module CancanUnitTest
  module ActionController
    module StubRegistry

      def _add_cancan_unit_test_stub(method, resource_type, model, options, &block)
        method_list = _get_cancan_unit_test_stubs(method)
        method_list << { resource_type: resource_type, model: model, options: options, block: block }
      end

      def _get_cancan_unit_test_stubs(method)
        cancan_unit_test_stubs[method] ||= []
      end

      private

      def cancan_unit_test_stubs
        @_cancan_unit_test_stubs ||= {}
      end

    end
  end
end

if defined? ActionController::Base
  ActionController::Base.class_eval do
    include CancanUnitTest::ActionController::StubRegistry
  end
end
