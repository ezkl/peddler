require 'forwardable'

require 'peddler/parser'

module Peddler
  # Internal: A client mix-in.
  module API
    def self.included(base)
      base.extend Forwardable

      base.def_delegators :@client, *Excon::HTTP_VERBS
    end

    def initialize(client)
      @client = client
    end

    # Internal: Builds a parameter list for bulk operations.
    #
    # name   - The String base name of the list.
    # values - A String value or an Array of values.
    #
    # Returns a Hash of parameters.
    def list(name, values)
      Array(values)
        .to_enum(:each_with_index)
        .reduce({}) do |a, (v, i)|
          a.update "#{name}List.#{name}.#{i + 1}" => v
        end
    end
  end
end