require 'stringio'

require 'peddler/api'

module Peddler
  module MWS
    # A Client to the Amazon MWS Products API.
    class Products
      include API

      def get_competitive_pricing
        raise NotImplementedError
      end

      def get_lowest_offers
        raise NotImplementedError
      end

      def get_matching
        raise NotImplementedError
      end

      def get_my_price
        raise NotImplementedError
      end

      def get_categories
        raise NotImplementedError
      end

      def list_matching
        raise NotImplementedError
      end

      # Returns the String service status of the API.
      def get_service_status
        res = request('GetServiceStatus')
        res.body.root.fetch('GetServiceStatusResponse')
                     .fetch('GetServiceStatusResult')
                     .fetch('Status')
      end

      private

      def request(action, params = {})
        get path: '/Products/2011-10-01',
            query: {
              'Action'        => action,
              'MarketplaceId' => marketplace
            }.merge(params)
        end
    end
  end
end
