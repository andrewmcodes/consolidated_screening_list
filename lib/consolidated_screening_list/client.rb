module ConsolidatedScreeningList
  class Client
    class << self
      #
      # <Description>
      #
      # @param [<Type>] options <description>
      # @option options [<Type>] :<key> <description>
      #
      # @return [<Type>] <description>
      #
      def search(options = {})
        Client.new.search(options)
      end
    end

    attr_reader :api_key

    #
    # <Description>
    #
    # @param [<Type>] options <description>
    # @option options [<Type>] :<key> <description>
    #
    def initialize(options = {})
      @api_key = options[:api_key] || ENV["TRADE_API_KEY"]
    end

    #
    # <Description>
    #
    # @param [<Type>] params <description>
    # @option params [<Type>] :<key> <description>
    #
    # @return [<Type>] <description>
    #
    def search(params = {})
      parse_response Query.new(params, api_key).call
    end

    private

    #
    # <Description>
    #
    # @param [<Type>] response <description>
    #
    # @return [<Type>] <description>
    #
    def parse_response(response)
      JSON.parse(response)["results"].map { |data| Result.new(data) }
    end
  end
end
