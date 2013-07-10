require 'spec_helper'

module CancanUnitTest
  module ActionController

    describe StubRegistry do

      class TestController
        include CancanUnitTest::ActionController::StubRegistry
      end

      subject(:test_controller) { TestController.new }

      let(:model) { :some_model }
      let(:options) { double(:options) }
      let(:block) { ->{} }

      let(:expected_stub_definition) do
        {
          model: model,
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
            test_controller._add_cancan_unit_test_stub(:falaffel, model, options, &block)
          end

          it "should be possible to find the stub with a matching key" do
            test_controller._get_cancan_unit_test_stubs(:falaffel).should == [expected_stub_definition]
          end

          context "adding another with the same model name" do
            let(:another_falaffel_model) { double(:model) }
            let(:another_falaffel_stub_definition) do
              {
                model: another_falaffel_model,
                options: options,
                block: block
              }
            end

            before do
              test_controller._add_cancan_unit_test_stub(:falaffel, another_falaffel_model, options, &block)
            end

            it "returns both stubs" do
              test_controller._get_cancan_unit_test_stubs(:falaffel).should ==
                [expected_stub_definition,
                 another_falaffel_stub_definition]
            end
          end

          context "adding another with a different model name" do
            let(:waffle_options) { { syrup: :maple } }
            let(:waffle_stub_definition) do
              {
                model: model,
                options: waffle_options,
                block: block
              }
            end

            before do
              test_controller._add_cancan_unit_test_stub(:waffle, model, waffle_options, &block)
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
