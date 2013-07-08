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

    describe "#stub_load_and_authorize_resource" do
      let(:controller) { double(:controller).as_null_object }
      let(:options) { double(:options) }
      let(:block) { -> {} }

      it "adds the stubbed resource to the controller" do
        controller.
          should_receive(:_cancan_stubs_add).
          with(:load_and_authorize_resource, :model, options, block)

        rspec_test.
          stub_load_and_authorize_resource(:model, options, &block)
      end
    end

  end
end


