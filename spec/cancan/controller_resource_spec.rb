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
        let_double(:stub_finder)
        let_double(:method)
        let(:model_name) { "TheModelName" }
        let_double(:options)
        let_double(:block_result)
        let_double(:controller)
        let(:block) { double(:block, call: block_result) }

        before do
          StubFinder.stub(:new).with(controller, :load_and_authorize_resource) { stub_finder }
          stub_finder.stub(:find).with(:the_model_name, options) { stub_finder_results }
          controller_resource.stub(:load_instance?) { load_instance }
        end

        context "when a stub doesn't exist for the resource" do
          let(:stub_finder_results) { nil }
          let(:load_instance) { true }

          it "calls through to the original method" do
            expect { controller_resource.load_and_authorize_resource }.to raise_error "original called"
          end
        end

        context "when a stub exists for the resource" do
          let(:stub_finder_results) { block }
          let(:load_instance) { true }

          context "when loading a single resource instance" do
            let(:load_instance) { true }

            it "calls the stub" do
              block.should_receive(:call)
              controller_resource.load_and_authorize_resource
            end

            it "assigns the stub to resource_instance" do
              controller_resource.should_receive(:resource_instance=).with(block_result)
              controller_resource.load_and_authorize_resource
            end
          end

          context "when loading a collection of resource instances" do
            let(:load_instance) { false }

            before do
              controller_resource.stub(:load_collection?) { true }
            end

            it "calls the stub" do
              block.should_receive(:call)
              controller_resource.load_and_authorize_resource
            end

            it "assigns the stub to collection_instance" do
              controller_resource.should_receive(:collection_instance=).with(block_result)
              controller_resource.load_and_authorize_resource
            end
          end

          context "when loading neither an instance, nor a collection, however that may happen?" do
            let(:load_instance) { false }

            before do
              controller_resource.stub(:load_collection?) { false }
            end

            it "does not call the stub" do
              block.should_not_receive(:call)
              controller_resource.load_and_authorize_resource
            end

            it "does not assign the stub to anything" do
              controller_resource.should_not_receive(:resource_instance=).with(block_result)
              controller_resource.should_not_receive(:collection_instance=).with(block_result)
              controller_resource.load_and_authorize_resource
            end
          end
        end

      end

    end
  end
end
