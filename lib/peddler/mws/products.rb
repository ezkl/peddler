
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

      # Returns the String service status of the Products API.
      def get_service_status
        url = products_url 'GetServiceStatus'
        res = Response.new connection.get url

        if res.valid?
          res.first 'Status'
        else
          raise BadResponse, res.first('Error')['Message']
        end
      end

      end
    end
  end
end
