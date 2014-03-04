require 'active_support/concern'
require 'active_support/inflector'

module CancanUnitTest
  module CanCan
    module ControllerResource
      extend ::ActiveSupport::Concern

      def self.show_warnings= value
        @show_warnings = value
      end

      def self.show_warnings
        @show_warnings ||= false
      end

      def _shim_load_and_authorize_resource
        model_name = resource_class.model_name.underscore
        method_name = :load_and_authorize_resource

        stub_finder = StubFinder.new(@controller, method_name)

        singleton_stub = stub_finder.find_by_singleton(model_name.to_sym, @options)
        collection_stub = stub_finder.find_by_collection(model_name.to_sym, @options)

        if (singleton_stub || collection_stub)
          self.resource_instance = singleton_stub.call if singleton_stub
          self.collection_instance = collection_stub.call if collection_stub
        else
          warn_about_missing_stub(model_name, method_name) if ControllerResource.show_warnings
          _original_load_and_authorize_resource
        end
      end

      def _shim_load_resource
        model_name = resource_class.model_name.underscore
        method_name = :load_resource

        stub_finder = StubFinder.new(@controller, method_name)

        singleton_stub = stub_finder.find_by_singleton(model_name.to_sym, @options)

        if singleton_stub
          self.resource_instance = singleton_stub.call if singleton_stub
        else
          warn_about_missing_stub(model_name, method_name) if ControllerResource.show_warnings
          _original_load_resource
        end
      end

      private

      def warn_about_missing_stub(model_name, method)
        puts("\e[33mCancanUnitTest Warning:\e[0m no stub found for '#{method} :#{model_name}'")
        ControllerResource.show_warnings = false
      end

      included do
        alias_method :_original_load_and_authorize_resource, :load_and_authorize_resource
        alias_method :load_and_authorize_resource, :_shim_load_and_authorize_resource

        alias_method :_original_load_resource, :load_resource
        alias_method :load_resource, :_shim_load_resource
      end
    end
  end
end


if defined? CanCan::ControllerResource
  CanCan::ControllerResource.class_eval do
    include CancanUnitTest::CanCan::ControllerResource
  end
end
