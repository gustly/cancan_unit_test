require 'spec_helper'

module CancanUnitTest
  module CanCan
    describe ControllerResource do
      class TestControllerResource
        def initialize(name, options, controller)
          @options = options
          @name = name
          @controller = controller
        end

        def resource_instance=(value) end

        def collection_instance=(value) end

        def load_and_authorize_resource
          raise "original called"
        end

        def load_resource
          raise "original called"
        end

        attr_reader :name

        include CancanUnitTest::CanCan::ControllerResource
      end

      let(:name) { :the_name }
      let(:controller_resource) { TestControllerResource.new(name, options, controller) }

      let_double(:controller)
      let_double(:options)

      let_double(:block_result)
      let(:block) { double(:block, call: block_result) }

      let_double(:stub_finder)

      describe "#load_and_authorize_resource" do
        before do
          StubFinder.stub(:new).with(controller, :load_and_authorize_resource) { stub_finder }
          stub_finder.stub(:find_by_singleton).with(:the_name, options) { singleton_results }
          stub_finder.stub(:find_by_collection).with(:the_name, options) { collection_results }
        end

        context "when a stub doesn't exist for the resource" do
          let(:singleton_results) { nil }
          let(:collection_results) { nil }

          it "calls through to the original method" do
            expect { controller_resource.load_and_authorize_resource }.to raise_error "original called"
          end

          context "when showing warning" do
            it "does not warn that there was no stub found" do
              ControllerResource.show_warnings = true
              STDOUT.should_receive(:puts).with("\e[33mCancanUnitTest Warning:\e[0m no stub found for 'load_and_authorize_resource :the_name'")
              begin
                controller_resource.load_and_authorize_resource
              rescue
              end
            end
          end

          context "when suppressing warning" do
            it "warns that there was no stub found" do
              ControllerResource.show_warnings = false
              STDOUT.should_not_receive(:puts).with("\e[33mCancanUnitTest Warning:\e[0m no stub found for 'load_and_authorize_resource :the_name'")
              begin
                controller_resource.load_and_authorize_resource
              rescue
              end
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

      describe "#load_resource" do
        before do
          StubFinder.stub(:new).with(controller, :load_resource) { stub_finder }
          stub_finder.stub(:find_by_singleton).with(:the_name, options) { singleton_results }
        end

        context "when a stub doesn't exist for the resource" do
          let(:singleton_results) { nil }

          it "calls through to the original method" do
            expect { controller_resource.load_resource }.to raise_error "original called"
          end

          context "when showing warning" do
            it "does not warn that there was no stub found" do
              ControllerResource.show_warnings = true
              STDOUT.should_receive(:puts).with("\e[33mCancanUnitTest Warning:\e[0m no stub found for 'load_resource :the_name'")
              begin
                controller_resource.load_resource
              rescue
              end
            end
          end

          context "when suppressing warning" do
            it "warns that there was no stub found" do
              ControllerResource.show_warnings = false
              STDOUT.should_not_receive(:puts).with("\e[33mCancanUnitTest Warning:\e[0m no stub found for 'load_resource :the_name'")
              begin
                controller_resource.load_resource
              rescue
              end
            end
          end
        end

        context "when a singleton stub for the resource exists" do
          let(:singleton_results) { block }
          let(:collection_results) { nil }

          it "calls the stub" do
            block.should_receive(:call)
            controller_resource.load_resource
          end

          it "assigns the stub to resource_instance" do
            controller_resource.should_receive(:resource_instance=).with(block_result)
            controller_resource.load_resource
          end
        end
      end
    end
  end
end
