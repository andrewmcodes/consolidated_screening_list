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
    # ConsolidatedScreeningList::Client initializer you receive from
    #
    # @param [String] api_key The CSL API key you receive from api.trade.gov
    #
    def initialize(api_key: nil)
      @api_key = api_key
    end

    #
    # <Description>
    #
    # @option params [Hash] :<key> <description>
    #
    # @return [Array] The search results.
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
