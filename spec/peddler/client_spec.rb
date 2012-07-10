require 'spec_helper'

module Peddler
  describe Client do
    let(:locale) { 'US' }
    let(:client) { Client.new locale }

    describe '.new' do
      it 'should require a valid locale' do
        expect { Client.new 'foo' }.to raise_error Client::BadLocale
      end
    end

    describe '#configure' do
      context 'given a block' do
        before do
          client.configure do |config|
            config.key = 'foo'
          end
        end

        it 'should set credentials' do
          client.key.should eq 'foo'
        end
      end

      context 'given a hash' do
        before do
          client.configure key: 'foo'
        end

        it 'should set credentials' do
          client.key.should eq 'foo'
        end
      end
    end

    describe '#endpoint' do
      subject { client.endpoint }

      it 'should return the API endpoint of the locale' do
        should match %r{https://mws}
      end
    end

    describe '#marketplace' do
      context 'given no value' do
        subject { client.marketplace }

        it 'should return the marketplace id for current locale' do
          should eql Client::MARKETPLACES['US']
        end
      end

      context 'given a locale' do
        subject { client.marketplace 'UK' }

        it 'should return the marketplace id for that locale' do
          should eql Client::MARKETPLACES['UK']
        end
      end
    end

    describe '#seller' do
      it 'should require a value' do
        expect {
          client.seller
        }.to raise_error Client::MissingSeller
      end
    end

    describe '#products' do
      subject { client.products }

      it 'should return the Products API' do
        should be_an MWS::Products
      end

      it 'should cache' do
        should be subject
      end
    end
  end
end
