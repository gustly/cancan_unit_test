require 'spec_helper'

module CancanUnitTest
  module CanCan
    describe ControllerResource do

      class TestControllerResource
        def initialize(model_name, options, controller)
          @options = options
          @model_name = model_name
          @controller = controller
        end

        def resource_instance=(value) end

        def collection_instance=(value) end

        def load_and_authorize_resource
          raise "original called"
        end

        def resource_class
          OpenStruct.new({ model_name: @model_name })
        end

        include CancanUnitTest::CanCan::ControllerResource
      end

      describe "#load_and_authorize_resource" do

        let(:controller_resource) { TestControllerResource.new(model_name, options, controller) }
        let(:model_name) { "TheModelName" }
        let_double(:controller)
        let_double(:options)

        let_double(:block_result)
        let(:block) { double(:block, call: block_result) }

        let_double(:stub_finder)

        before do
          StubFinder.stub(:new).with(controller, :load_and_authorize_resource) { stub_finder }
          stub_finder.stub(:find_by_singleton).with(:the_model_name, options) { singleton_results }
          stub_finder.stub(:find_by_collection).with(:the_model_name, options) { collection_results }
        end

        context "when a stub doesn't exist for the resource" do
          let(:singleton_results) { nil }
          let(:collection_results) { nil }

          it "calls through to the original method" do
            expect { controller_resource.load_and_authorize_resource }.to raise_error "original called"
          end

          it "warns that there was no stub found" do
            STDOUT.should_receive(:puts).with("\e[33mCancanUnitTest Warning:\e[0m no stub found for 'load_and_authorize_resource :the_model_name'")
            begin
              controller_resource.load_and_authorize_resource
            rescue
            end
          end
        end

        context "when a singleton stub for the resource exists" do
          let(:singleton_results) { block }
          let(:collection_results) { nil }

          it "calls the stub" do
            block.should_receive(:call)
            controller_resource.load_and_authorize_resource
          end

          it "assigns the stub to resource_instance" do
            controller_resource.should_receive(:resource_instance=).with(block_result)
            controller_resource.load_and_authorize_resource
          end
        end

        context "when a collection stub for the resource exists" do
          let(:singleton_results) { nil }
          let(:collection_results) { block }

          it "calls the stub" do
            block.should_receive(:call)
            controller_resource.load_and_authorize_resource
          end

          it "assigns the stub to collection_instance" do
            controller_resource.should_receive(:collection_instance=).with(block_result)
            controller_resource.load_and_authorize_resource
          end
        end
      end
    end
  end
end
