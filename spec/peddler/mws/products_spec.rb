require 'spec_helper'

module Peddler
  module MWS
    describe Products do
      let(:client) do
        Client.new('US').tap do |c|
          c.configure mws['US']
        end
      end

      let(:products) { client.products }

      describe '#get', :vcr do
        it 'should get the service status' do
          products
            .get('GetServiceStatus')
            .body
            .root
            .fetch('GetServiceStatusResponse')
            .fetch('GetServiceStatusResult')
            .fetch('Status')
            .should match /GREEN|GREEN_I|YELLOW|RED/
        end

        it 'should get the lowest offer listings for ASINs' do
          params = products.list 'ASIN', Asins.first(20)
          res = products
            .get('GetLowestOfferListingsForASIN', params)
            .body
            .root
            .fetch('GetLowestOfferListingsForASINResponse')
            .fetch('GetLowestOfferListingsForASINResult')
            .should have(20).products
        end
      end
    end
  end
end
