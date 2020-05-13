module ConsolidatedScreeningList
  class Query
    class << self
      #
      # All valid country codes
      #
      # @return [Array] Valid ISO country codes
      #
      def countries
        @countries ||= IsoCountryCodes.all.map { |c| c.alpha2 }
      end

      #
      # "https://api.trade.gov/gateway/v1/consolidated_screening_list/search"
      #
      # @return [String] seach url
      #
      def endpoint
        @endpoint ||= URI.join(ConsolidatedScreeningList::PRODUCTION_URL, "search").to_s
      end
    end

    attr_reader :api_key

    #
    # Initializer
    #
    # @param [Hash] params <description>
    # @param [String] api_key <description>
    #
    def initialize(params: nil, api_key: nil)
      params = {q: params} if params.is_a? String
      @params = ConsolidatedScreeningList::PARAMETERS.merge(params)
      @api_key = api_key
      validate_params
      validate_source
      validate_countries
      validate_type
      validate_api_key
    end

    #
    # The response object
    #
    # @return [RestClient::Response] Response object
    #
    def call
      RestClient.get Query.endpoint, {
        :params => params,
        "Authorization" => "Bearer #{@api_key}",
        "User-Agent" => ConsolidatedScreeningList.user_agent
      }
    end

    private

    #
    # Validates the type is valid
    #
    # @return [nil] Will raise if type is invalid, otherwise returns nil.
    #
    def validate_type
      return unless @params[:type]
      raise ArgumentError, "Invalid parameter: #{@params[:type]}" unless ConsolidatedScreeningList::TYPES.include?(@params[:type])
    end

    #
    # Validates the sources are valid
    #
    # @return [nil] Will raise if params are invalid, otherwise returns nil.
    #
    def validate_params
      invalid_parameter = @params.find { |key, value| !ConsolidatedScreeningList::PARAMETERS.key?(key) }
      raise ArgumentError, "Invalid parameter: #{@params}" if invalid_parameter
    end

    #
    # Validates the sources are valid
    #
    # @return [nil] Will raise if sources are invalid, otherwise returns nil.
    #
    def validate_source
      invalid_source = @params[:sources].find { |source| !Source.find_by_key(source) }
      raise ArgumentError, "Invalid source: #{@params[:sources]}" if invalid_source
    end

    #
    # Validates the countries are valid ISO abbreviations
    #
    # @return [nil] Will raise if countries is invalid, otherwise returns nil.
    #
    def validate_countries
      invalid_country = @params[:countries].find { |country| !Query.countries.include?(country) }
      raise ArgumentError, "Invalid country: #{@params[:countries]}" if invalid_country
    end

    #
    # Validates the api_key is a valid UUID
    #
    # @return [nil] Will raise if api_key is invalid, otherwise returns nil.
    #
    def validate_api_key
      invalid_api_key = !!api_key.match(/\A[\da-f]{8}-[\da-f]{4}-[\da-f]{4}-[\da-f]{4}-[\da-f]{12}\z/i)
      raise ArgumentError, "Invalid API key: #{api_key}" unless invalid_api_key
    end

    #
    # The parameters we will use to query the API
    #
    # @return [Hash] API params. Default keys: [:q, :sources, :countries, :fuzzy_name, :size, :size, :offset]
    #
    def params
      params = @params.clone
      params[:countries] = params[:countries].join(",")
      params[:sources] = params[:sources].join(",")
      params.reject { |k, v| v.nil? }
    end
  end
end
