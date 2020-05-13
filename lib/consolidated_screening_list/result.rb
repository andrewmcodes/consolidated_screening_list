module ConsolidatedScreeningList
  class Result
    attr_reader :data

    #
    # <Description>
    #
    # @param [<Type>] data <description>
    #
    def initialize(data)
      @data = data
    end

    #
    # [#<ConsolidatedScreeningList::Result name="JOHN B. PRIDMORE-SMITH">]
    #
    # @return [String] <description>
    #
    def inspect
      "#<ConsolidatedScreeningList::Result name=\"#{name}\">"
    end

    #
    # <Description>
    #
    # @param [<Type>] method_name <description>
    # @param [<Type>] *arguments <description>
    # @param [<Type>] &block <description>
    #
    # @return [<Type>] <description>
    #
    def method_missing(method_name, *arguments, &block)
      if data.key?(method_name.to_s)
        data[method_name.to_s]
      else
        super
      end
    end

    #
    # <Description>
    #
    # @param [<Type>] method_name <description>
    # @param [<Type>] include_private <description>
    #
    # @return [<Type>] <description>
    #
    def respond_to_missing?(method_name, include_private = false)
      if data.key?(method_name.to_s)
        true
      else
        super
      end
    end
  end
end
