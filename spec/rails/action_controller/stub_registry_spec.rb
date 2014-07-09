require 'spec_helper'

module CancanUnitTest
  module ActionController

    describe StubRegistry do

      class TestController
        include CancanUnitTest::ActionController::StubRegistry
      end

      subject(:test_controller) { TestController.new }

      let(:resource) { :some_resource }
      let(:options) { double(:options) }
      let(:block) { ->{} }

      let(:expected_singleton_definition) do
        {
          resource_type: :singleton,
          resource: resource,
          options: options,
          block: block
        }
      end

      let(:expected_collection_definition) do
        {
          resource_type: :collection,
          resource: resource,
          options: options,
          block: block
        }
      end
      describe "retrieving a stored stub definition" do
        context "no stubs added" do
          it "returns an empty array" do
            test_controller._get_cancan_unit_test_stubs(:mango).should == []
          end

          it "does not raise an error" do
            expect { test_controller._get_cancan_unit_test_stubs(:mango) }.not_to raise_error
          end
        end

        context "added one stub" do
          before do
            test_controller._add_cancan_unit_test_stub(:falaffel, :singleton, resource, options, &block)
          end

          it "should be possible to find the stub with a matching key" do
            test_controller._get_cancan_unit_test_stubs(:falaffel).should == [expected_singleton_definition]
          end

          context "adding another with the same resource name" do
            let(:another_singleton_definition) do
              {
                resource_type: :singleton,
                resource: resource,
                options: options,
                block: block
              }
            end

            context "and the same resource type" do
              before do
                test_controller._add_cancan_unit_test_stub(:falaffel, :singleton, resource, options, &block)
              end

              it "returns both stubs" do
                test_controller._get_cancan_unit_test_stubs(:falaffel).should ==
                  [expected_singleton_definition,
                   another_singleton_definition]
              end
            end

            context "and a different resource type" do
              before do
                test_controller._add_cancan_unit_test_stub(:falaffel, :collection, resource, options, &block)
              end

              it "returns both stubs" do
                test_controller._get_cancan_unit_test_stubs(:falaffel).should ==
                  [expected_singleton_definition,
                   expected_collection_definition]
              end
            end
          end

          context "adding another with a different resource name" do
            let(:waffle_options) { { syrup: :maple } }
            let(:waffle_stub_definition) do
              {
                resource_type: :singleton,
                resource: resource,
                options: waffle_options,
                block: block
              }
            end

            before do
              test_controller._add_cancan_unit_test_stub(:waffle, :singleton, resource, waffle_options, &block)
            end

            it "return the other definition" do
              test_controller._get_cancan_unit_test_stubs(:waffle).should ==
                [waffle_stub_definition]
            end
          end

          context "when the method has no definitions" do
            it "returns an empty array" do
              test_controller._get_cancan_unit_test_stubs(:gyro).should == []
            end
          end
        end
      end

    end

  end
end
