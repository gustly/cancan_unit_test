require 'active_support/concern'
require 'active_support/inflector'

module CancanUnitTest
  module CanCan
    module ControllerResource
      extend ::ActiveSupport::Concern

      def _shim_load_and_authorize_resource
        stub_finder = StubFinder.new(@controller, :load_and_authorize_resource)
        stub = stub_finder.find(resource_class.model_name.underscore.to_sym, @options)

        if stub.nil?
          _original_load_and_authorize_resource
        else
          if load_instance?
            self.resource_instance = stub.call
          elsif load_collection?
            self.collection_instance = stub.call
          end
        end
      end

      included do
        alias_method :_original_load_and_authorize_resource, :load_and_authorize_resource
        alias_method :load_and_authorize_resource, :_shim_load_and_authorize_resource
      end
    end
  end
end


if defined? CanCan::ControllerResource
  CanCan::ControllerResource.class_eval do
    include CancanUnitTest::CanCan::ControllerResource
  end
end
