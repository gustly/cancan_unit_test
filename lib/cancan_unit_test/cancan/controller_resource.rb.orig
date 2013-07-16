require 'active_support/concern'
require 'active_support/inflector'

module CancanUnitTest
  module CanCan
    module ControllerResource
      extend ::ActiveSupport::Concern

      def _shim_load_and_authorize_resource
        model_name = resource_class.model_name.underscore

        stub_finder = StubFinder.new(@controller, :load_and_authorize_resource)

        singleton_stub = stub_finder.find_by_singleton(model_name.to_sym, @options)
        collection_stub = stub_finder.find_by_collection(model_name.to_sym, @options)

        if (singleton_stub || collection_stub)
          self.resource_instance = singleton_stub.call if singleton_stub
          self.collection_instance = collection_stub.call if collection_stub
        else
          puts("\e[33mCancanUnitTest Warning:\e[0m no stub found for 'load_and_authorize_resource :#{model_name}'")
          _original_load_and_authorize_resource
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
