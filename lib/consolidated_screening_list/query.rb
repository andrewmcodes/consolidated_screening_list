module ConsolidatedScreeningList
  class Query
    class << self
      #
      # <Description>
      #
      # @return [<Type>] <description>
      #
      def countries
        @countries ||= IsoCountryCodes.all.map { |c| c.alpha2 }
      end

      #
      # <Description>
      #
      # @return [<Type>] <description>
      #
      def endpoint
        @endpoint ||= URI.join(ConsolidatedScreeningList::PRODUCTION_URL, "search").to_s
      end
    end

    PARAMETERS = {
      q: nil,
      sources: Source.keys,
      countries: Query.countries,
      address: nil,
      name: nil,
      fuzzy_name: false,
      type: nil,
      size: 100,
      offset: 0
    }

    TYPES = %w[
      Individual
      Entity
      Vessel
    ]

    attr_reader :api_key

    #
    # <Description>
    #
    # @param [<Type>] params <description>
    # @param [<Type>] api_key <description>
    #
    def initialize(params: nil, api_key: nil)
      params = {q: params} if params.is_a? String
      @params = PARAMETERS.merge(params)
      @api_key = api_key
      invalid_parameter = @params.find { |key, value| !PARAMETERS.key?(key) }
      invalid_source = @params[:sources].find { |source| !Source.find_by_key(source) }
      invalid_country = @params[:countries].find { |country| !Query.countries.include?(country) }
      raise ArgumentError, "Invalid parameter: #{invalid[0]}" if invalid_parameter
      raise ArgumentError, "Invalid source: #{invalid}" if invalid_source
      raise ArgumentError, "Invalid country: #{invalid}" if invalid_country
      validate_api_key
    end

    #
    # <Description>
    #
    # @return [<Type>] <description>
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
    # Validates the api_key is a valid UUID
    #
    # @return [nil] Will raise if api_key is invalid, otherwise returns nil.
    #
    def validate_api_key
      invalid_api_key = !!api_key.match(/\A[\da-f]{8}-[\da-f]{4}-[\da-f]{4}-[\da-f]{4}-[\da-f]{12}\z/i)
      raise ArgumentError, "Invalid API key: #{api_key}" unless invalid_api_key
    end

    #
    # <Description>
    #
    # @return [<Type>] <description>
    #
    def params
      params = @params.clone
      params[:countries] = params[:countries].join(",")
      params[:sources] = params[:sources].join(",")
      params.reject { |k, v| v.nil? }
    end
  end
end

# module ConsolidatedScreeningList
#   class Query
#     class << self
#       #
#       # All valid country codes
#       #
#       # @return [Array] Valid ISO country codes
#       #
#       def countries
#         @countries ||= IsoCountryCodes.all.map { |c| c.alpha2 }
#       end

#       #
#       # "https://api.trade.gov/gateway/v1/consolidated_screening_list/search"
#       #
#       # @return [String] seach url
#       #
#       def endpoint
#         @endpoint ||= URI.join(ConsolidatedScreeningList::PRODUCTION_URL, "search").to_s
#       end
#     end

#     PARAMETERS = {
#       q: nil,
#       sources: Source.keys,
#       countries: Query.countries,
#       address: nil,
#       name: nil,
#       fuzzy_name: false,
#       type: nil,
#       size: 100,
#       offset: 0
#     }

#     TYPES = %w[
#       Individual
#       Entity
#       Vessel
#     ]

#     attr_reader :api_key, :params
#     #
#     # <Description>
#     #
#     # @param [<Type>] params <description>
#     # @param [<Type>] api_key <description>
#     #
#     def initialize(params, api_key: nil)
#       params = {q: params} if params.is_a? String
#       @params = PARAMETERS.merge(params)
#       @api_key = api_key
#       invalid_parameter = @params.find { |key, value| !PARAMETERS.key?(key) }
#       raise ArgumentError, "Invalid parameter: #{invalid[0]}" if invalid_parameter
#       invalid_source = @params[:sources].find { |source| !Source.find_by_key(source) }
#       raise ArgumentError, "Invalid source: #{invalid}" if invalid_source
#       validate_countries
#       validate_api_key
#     end

#     #
#     # <Description>
#     #
#     # @return [<Type>] <description>
#     #
#     def call
#       RestClient.get Query.endpoint, {
#         :params => params,
#         "Authorization" => "Bearer #{@api_key}",
#         "User-Agent" => ConsolidatedScreeningList.user_agent
#       }
#     end

#     private

#     #
#     # Validates the countries are valid
#     #
#     # @return [nil] Will raise if countries are invalid, otherwise returns nil.
#     #
#     def validate_countries
#       invalid_country = params[:countries].find { |country| !Query.countries.include?(country) }
#       raise ArgumentError, "Invalid country: #{invalid}" if invalid_country
#     end

#     #
#     # Validates the api_key is a valid UUID
#     #
#     # @return [nil] Will raise if api_key is invalid, otherwise returns nil.
#     #
#     def validate_api_key
#       invalid_api_key = !!api_key.match(/\A[\da-f]{8}-[\da-f]{4}-[\da-f]{4}-[\da-f]{4}-[\da-f]{12}\z/i)
#       raise ArgumentError, "Invalid API key: #{api_key}" unless invalid_api_key
#     end

#     #
#     # <Description>
#     #
#     # @return [<Type>] <description>
#     #
#     def params
#       params = @params.clone
#       params[:countries] = params[:countries].join(",")
#       params[:sources] = params[:sources].join(",")
#       params.reject { |k, v| v.nil? }
#     end
#   end
# end
