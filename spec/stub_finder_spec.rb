require 'spec_helper'

module CancanUnitTest
  describe StubFinder do
    let_double(:controller)
    let_double(:method)
    let_double(:model)
    let_double(:options)
    let_double(:block)

    let(:finder) { StubFinder.new(controller, method) }

    describe "#find_by_singleton" do
      subject { finder.find_by_singleton(model, options) }

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
          let(:results) { [{ resource_type: :singleton, model: double(:other_model), options: options, block: block }] }
          it { should be_nil }
        end

        context "with no matching options" do
          let(:results) { [{ resource_type: :singleton, model: model, options: double(:other_options), block: block }] }
          it { should be_nil }
        end

        context "with matching model and options" do
          let(:results) { [{ resource_type: :singleton, model: model, options: options, block: block }] }
          it { should == block }
        end
      end

      context "the controller has more than one matching stub" do
        context "with a different resource type" do
          let(:results) do
            [
              { resource_type: :collection, model: model, options: options, block: -> {} },
              { resource_type: :singleton, model: model, options: options, block: block }
            ]
          end

          it { should == block }
        end

        context "with the same resource type" do
          let(:results) do
            [
              { resource_type: :singleton, model: model, options: options, block: block },
              { resource_type: :singleton, model: model, options: options, block: block }
            ]
          end

          it "raises an exception" do
            expect { finder.find_by_singleton(model, options) }.to raise_error
          end
        end
      end

    end

    describe "#find_by_collection" do
      subject { finder.find_by_collection(model, options) }

      before do
        controller.
          stub(:_get_cancan_unit_test_stubs).
          with(method).
          and_return(results)
      end

      context "with a different resource type" do
        let(:results) do
          [
            { resource_type: :singleton, model: model, options: options, block: -> {} },
            { resource_type: :collection, model: model, options: options, block: block }
          ]
        end

        it { should == block }
      end
    end

  end
end
