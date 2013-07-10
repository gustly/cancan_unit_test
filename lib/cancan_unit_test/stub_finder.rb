module CancanUnitTest
  class StubFinder

    def initialize(controller, method)
      @stub_list = controller._get_cancan_unit_test_stubs(method)
    end

    def find(model, options)
      stub_list = filter_stub_list(model, options)

      return nil if stub_list.empty?

      raise "Ambiguous match in CanCan:Mocks" if stub_list.count > 1

      stub_list.first[:block]
    end

    private

    def filter_stub_list(model, options)
      stub_list.select do |stub|
        stub[:model] == model &&
          stub[:options] == options
      end
    end

    attr_reader :stub_list

  end
end
