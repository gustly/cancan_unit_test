require 'spec_helper'

module CancanUnitTest
  describe StubFinder do
    let_double(:controller)
    let_double(:method)
    let_double(:model)
    let_double(:options)
    let_double(:block)

    let(:finder) { StubFinder.new(controller, method) }

    describe "#find" do
      subject { finder.find(model, options) }

      before do
        controller.
          stub(:_get_cancan_unit_test_stubs).
          with(method).
          and_return(results)
      end

      context "the controller has no stubs" do
        let(:results) { [] }
        it { should be_nil }
      end

      context "the controller has a stub for the method" do
        context "with no matching model" do
          let(:results) { [{ model: double(:other_model), options: options, block: block }] }
          it { should be_nil }
        end

        context "with no matching options" do
          let(:results) { [{ model: model, options: double(:other_options), block: block }] }
          it { should be_nil }
        end

        context "with matching model and options" do
          let(:results) { [{ model: model, options: options, block: block }] }
          it { should == block }
        end
      end

      context "the controller has more than one matching stub" do
        let(:results) do
          [
            { model: model, options: options, block: block },
            { model: model, options: options, block: block }
          ]
        end

        it "raises an exception" do
          expect { finder.find(model, options) }.to raise_error
        end
      end
    end

  end
end
