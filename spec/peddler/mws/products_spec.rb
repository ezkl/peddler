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

      describe '#get_service_status', vcr: { record: :all } do
        subject { products.service_status }

        it 'returns the service status' do
          pending
          should match /GREEN|GREEN_I|YELLOW|RED/
        end
      end
    end
  end
end
