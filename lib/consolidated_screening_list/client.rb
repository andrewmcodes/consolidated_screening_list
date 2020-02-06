module ConsolidatedScreeningList
  class Client
    class << self
      def search(options = {})
        Client.new.search(options)
      end
    end

    attr_reader :api_key

    def initialize(options = {})
      @api_key = options[:api_key] || ENV["TRADE_API_KEY"]
    end

    def search(params = {})
      parse_response Query.new(params, api_key).call
    end

    private

    def parse_response(response)
      JSON.parse(response)["results"].map { |data| Result.new(data) }
    end
  end
end
