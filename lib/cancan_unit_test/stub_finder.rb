module CancanUnitTest
  class StubFinder

    def initialize(controller, method)
      @stub_list = controller._get_cancan_unit_test_stubs(method)
    end

    def find_by_singleton(model, options)
      find_by_resource_type(model, :singleton, options)
    end

    def find_by_collection(model, options)
      find_by_resource_type(model, :collection, options)
    end

    private

    def find_by_resource_type(model, resource_type, options)
      filtered_stub_list = filter_stub_list(model, resource_type, options)

      return nil if filtered_stub_list.empty?

      raise "Ambiguous match in CanCan:Mocks" if filtered_stub_list.count > 1

      filtered_stub_list.first[:block]
    end

    def filter_stub_list(model, resource_type, options)
      stub_list.select do |stub|
        stub[:resource_type] == resource_type &&
          stub[:model] == model &&
          stub[:options] == options 
      end
    end

    attr_reader :stub_list

  end
end
