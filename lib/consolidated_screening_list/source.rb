module ConsolidatedScreeningList
  class Source
    # @return [Hash] Available Screening Lists where the key is the abbreviation and value is the full name.
    SOURCES = {
      "CAP" => "Correspondent Account or Payable-Through Account Sanctions (CAPTA)",
      "DPL" => "Denied Persons List",
      "DTC" => "ITAR Debarred",
      "EL" => "Entity List",
      "FSE" => "Foreign Sanctions Evaders",
      "ISN" => "Nonproliferation Sanctions",
      "PIB" => "Persons Identified as Blocked",
      "PLC" => "Palestinian Legislative Council List",
      "SDN" => "Specially Designated Nationals",
      "SSI" => "Sectoral Sanctions Identifications List",
      "UVL" => "Unverified List",
      "561" => "Part 561 List"
    }.freeze

    class << self
      #
      # <Description>
      #
      # @return [<Type>] <description>
      #
      def all
        @all ||= SOURCES.map { |key, value| new(key) }
      end

      #
      # <Description>
      #
      # @param [<Type>] key <description>
      #
      # @return [<Type>] <description>
      #
      def find_by_key(key)
        all.find { |source| source.key == key }
      end
      alias [] find_by_key

      #
      # <Description>
      #
      # @param [<Type>] name <description>
      #
      # @return [<Type>] <description>
      #
      def find_by_name(name)
        all.find { |source| source.name == name }
      end

      #
      # <Description>
      #
      # @return [<Type>] <description>
      #
      def keys
        @keys ||= SOURCES.keys
      end
    end

    attr_reader :key

    #
    # <Description>
    #
    # @param [<Type>] key <description>
    #
    def initialize(key)
      @key = key
    end

    #
    # <Description>
    #
    # @return [<Type>] <description>
    #
    def inspect
      "#<ConsolidatedScreeningList::Source key=\"#{key}\" name=\"#{name}\">"
    end

    #
    # <Description>
    #
    # @return [<Type>] <description>
    #
    def name
      SOURCES[key]
    end
  end
end
