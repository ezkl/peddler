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
      def service_status
        parser = Parser.new

        streamer = ->(chunk, remaining, total) {
          Ox.sax_parse parser, StringIO.new(chunk)
        }

        res = get path: '/Products/2011-10-01',
            query: {
              'Action' => 'GetServiceStatus',
              'MarketplaceId' => @client.marketplace
            },
            response_block: streamer,
            scheme: 'https'

        parser.root.fetch(:get_service_status_response)
                   .fetch(:get_service_status_result)
                   .fetch(:status)
      end
    end
  end
end
