require 'forwardable'

require 'peddler/api'

module Peddler
  module MWS
    # A Client to the Amazon MWS Products API.
      def get_competitive_pricing_for_asin
        raise NotImplementedError
      end
    class Products
      include API

      def get_competitive_pricing_for_sku
        raise NotImplementedError
      end

      # Gets the lowest price offer listings for a product.
      #
      # asins     - A String or Array list of up to 20 ASINs.
      # condition - The String item condition scope (default: nil)
      #
      # Returns a Peddler::Response.
      def get_lowest_offer_listings_for_asin(asins, condition = nil)
        params = { 'Action' => 'GetLowestOfferListingsForASIN' }
        params.update list 'ASIN', asins
        params.store 'ItemCondition', condition if condition

        Response.new get query: params
      end

      def get_lowest_offer_listings_for_sku
        raise NotImplementedError
      end

      # Gets a list of products and their attributes.
      #
      # asins - A String or Array list of up to 10 ASINs.
      #
      # Returns a MWS::Response.
      #
      # Raises a BadResponse if response is not valid.
      def get_matching_product(asins)
        params = build_list 'ASIN', asins
        url = products_url 'GetMatchingProduct', params

        res = Response.new connection.get url

        if res.valid?
          res
        else
          raise BadResponse, res.first('Error')['Message']
        end
      end

      def get_my_price_for_asin
        raise NotImplementedError
      end

      def get_my_price_for_sku
        raise NotImplementedError
      end

      def get_product_categories_for_asin
        raise NotImplementedError
      end

      def get_product_categories_for_sku
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

      def list_matching_products
        raise NotImplementedError
      end
    end
  end
end
