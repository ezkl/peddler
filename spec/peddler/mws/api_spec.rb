require 'spec_helper'

module Peddler
  module MWS
    describe API do
      let(:api)    { API.new client }
      let(:client) { Client.new 'US' }

      describe '#list' do
        subject { api.list 'Key', (1..10).to_a }

        it 'should use dot notation' do
          1.upto(10).each do |count|
            should include "KeyList.Key.#{count}"
          end
        end
      end

      Excon::HTTP_VERBS.each do |method|
        describe "##{method.upcase}" do
          it "should delegate to the client" do
            client.should_receive method
            api.send method
          end
        end
      end
    end
  end
end
