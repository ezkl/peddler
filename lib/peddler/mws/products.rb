require 'stringio'

require 'peddler/api'

module Peddler
  module MWS
    # A Client to the Amazon MWS Products API.
    class Products
      include API

      # Gets a resource from the Products API.
      #
      # action - The String action to perform.
      # params - A Hash of parameters (default: {}).
      #
      # Returns an Excon::Response.
      def get(action, params = {})
        client.get path: '/Products/2011-10-01',
                   query: {
                     'Action'        => action,
                     'MarketplaceId' => client.marketplace
                   }.merge(params)
        end
    end
  end
end
