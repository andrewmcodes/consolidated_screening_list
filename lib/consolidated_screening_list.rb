require "iso_country_codes"
require "rest_client"
require "uri"
require "logger"
require "json"

require "consolidated_screening_list/version"
require "consolidated_screening_list/source"
require "consolidated_screening_list/result"
require "consolidated_screening_list/client"
require "consolidated_screening_list/query"

RestClient.log = STDOUT unless ENV["DEBUG"].to_s.empty?

module ConsolidatedScreeningList
  class Error < StandardError; end

  API_VERSION = "v1"
  PRODUCTION_URL = "https://api.trade.gov/gateway/#{API_VERSION}/consolidated_screening_list/".freeze
  TYPES = %w[Individual Entity Vessel]
  PARAMETERS = {q: nil, sources: Source.keys, countries: Query.countries, address: nil, name: nil, fuzzy_name: false, type: nil, size: 100, offset: 0}

  #
  # User agent
  #
  # @return [String] The user agent
  #
  def self.user_agent
    "ConsolidatedScreeningList/#{ConsolidatedScreeningList::VERSION}; +https://github.com/andrewmcodes/consolidated_screening_list)"
  end
end
