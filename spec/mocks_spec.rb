require 'spec_helper'

module CancanUnitTest
  describe Mocks do

    class TestClass
      include CancanUnitTest::Mocks

      attr_reader :controller

      def initialize(controller)
        @controller = controller
      end
    end

    subject(:rspec_test) { TestClass.new(controller) }

    let(:controller) { double(:controller).as_null_object }
    let(:options) { double(:options) }
    let(:block) { Proc.new{} }

    describe "#stub_load_and_authorize_singleton_resource" do

      it "adds the stubbed resource to the controller" do
        controller.
          should_receive(:_add_cancan_unit_test_stub).
          with(:load_and_authorize_resource, :singleton, :model, options, &block)

        rspec_test.
          stub_load_and_authorize_singleton_resource(:model, options, &block)
      end

      it "does not require options" do
        expect do
          rspec_test.
            stub_load_and_authorize_singleton_resource(:model, &block)
        end.to_not raise_error
      end
    end

    describe "#stub_load_and_authorize_collection_resource" do
      it "adds the stubed resource collection to the controller" do
        controller.should_receive(:_add_cancan_unit_test_stub).
          with(:load_and_authorize_resource, :collection, :model, options, &block)

        rspec_test.
          stub_load_and_authorize_collection_resource(:model, options, &block)
      end
    end

    describe "#stub_load_singleton_resource" do
      it "adds the stubbed singleton resource to the controller" do
        controller.should_receive(:_add_cancan_unit_test_stub).
          with(:load_resource, :singleton, :model, options, &block)

        rspec_test.
          stub_load_singleton_resource(:model, options, &block)
      end
    end
  end
end


