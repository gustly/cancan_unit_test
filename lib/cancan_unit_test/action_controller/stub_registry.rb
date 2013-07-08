module CancanUnitTest
  module ActionController
    module StubRegistry

      def _add_cancan_unit_test_stub(method, model, options, &block)
        @_cancan_unit_test_stubs ||= {}
        method_list = @_cancan_unit_test_stubs[method] ||= []
        method_list << { model: model, options: options, block: block }
      end

      def _get_cancan_unit_test_stubs(method)
        @_cancan_unit_test_stubs[method] || []
      end

    end
  end
end

