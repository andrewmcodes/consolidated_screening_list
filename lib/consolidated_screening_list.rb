require "iso_country_codes"
require "rest_client"
require "dotenv"
require "uri"
require "logger"
require "json"

require "consolidated_screening_list/version"
require "consolidated_screening_list/source"
require "consolidated_screening_list/result"
require "consolidated_screening_list/client"
require "consolidated_screening_list/query"

Dotenv.load
RestClient.log = STDOUT unless ENV["DEBUG"].to_s.empty?

module ConsolidatedScreeningList
  class Error < StandardError; end

  API_VERSION = "v1"
  PRODUCTION_URL = "https://api.trade.gov/gateway/#{API_VERSION}/consolidated_screening_list/".freeze
  TYPES = %w[Individual Entity Vessel]
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
  #
  # <Description>
  #
  # @return [<Type>] <description>
  #
  def self.user_agent
    "ConsolidatedScreeningList/#{ConsolidatedScreeningList::VERSION}; +https://github.com/andrewmcodes/consolidated_screening_list)"
  end
end
