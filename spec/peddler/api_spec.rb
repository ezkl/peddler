require 'spec_helper'

module Peddler
  describe API do
    let(:api) { Class.new { include API }.new client }
    let(:client) { double 'client' }

    describe '#list' do
      subject { api.list 'Key', (1..10).to_a }

      it 'should use dot notation' do
        1.upto(10).each do |count|
          should include "KeyList.Key.#{count}"
        end
      end
    end
  end
end
