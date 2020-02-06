module ConsolidatedScreeningList
  class Result
    attr_reader :data

    def initialize(data)
      @data = data
    end

    def inspect
      "#<ConsolidatedScreeningList::Result name=\"#{name}\">"
    end

    def method_missing(method_name, *arguments, &block)
      if data.key?(method_name.to_s)
        data[method_name.to_s]
      else
        super
      end
    end

    def respond_to_missing?(method_name, include_private = false)
      if data.key?(method_name.to_s)
        true
      else
        super
      end
    end
  end
end
