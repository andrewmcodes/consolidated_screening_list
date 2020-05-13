module ConsolidatedScreeningList
  class Query
    class << self
      def countries
        @countries ||= IsoCountryCodes.all.map { |c| c.alpha2 }
      end

      def endpoint
        @endpoint ||= URI.join(ConsolidatedScreeningList::API_BASE, "search").to_s
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
      offset: 0,
    }

    TYPES = %w[
      Individual
      Entity
      Vessel
    ]

    def initialize(params, api_key)
      params = {q: params} if params.is_a? String
      @params = PARAMETERS.merge(params)
      @api_key = api_key
      invalid_parameter = @params.find { |key, value| !PARAMETERS.key?(key) }
      invalid_source = @params[:sources].find { |source| !Source.find_by_key(source) }
      invalid_country = @params[:countries].find { |country| !Query.countries.include?(country) }
      invalid_api_key = !UUID.validate(api_key)
      raise ArgumentError, "Invalid parameter: #{invalid[0]}" if invalid_parameter
      raise ArgumentError, "Invalid source: #{invalid}" if invalid_source
      raise ArgumentError, "Invalid country: #{invalid}" if invalid_country
      raise ArgumentError, "Invalid API key: #{invalid}" if invalid_api_key
    end

    def call
      RestClient.get Query.endpoint, {
        :params => params,
        "Authorization" => "Bearer #{@api_key}",
        "User-Agent" => ConsolidatedScreeningList.user_agent,
      }
    end

    private

    def params
      params = @params.clone
      params[:countries] = params[:countries].join(",")
      params[:sources] = params[:sources].join(",")
      params.reject { |k, v| v.nil? }
    end
  end
end