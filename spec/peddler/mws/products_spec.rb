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

      describe '#get_service_status', :vcr do
        subject { products.get_service_status }

        it 'returns the service status' do
          should match /GREEN|GREEN_I|YELLOW|RED/
        end
      end
    end
  end
end
