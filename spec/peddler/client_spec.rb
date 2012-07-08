require 'spec_helper'

module Peddler
  describe Client do
    let(:client) { Client.new 'US' }

    it 'should use Jeff' do
      Client.included_modules.should include Jeff
    end

    describe '.new' do
      it 'should require a valid locale' do
        expect {
          Client.new 'foo'
        }.to raise_error Client::BadLocale
      end

      context 'given a hash' do
        it 'should set credentials' do
          hsh = {}
          Client.any_instance.should_receive(:configure).with(hsh)
          Client.new 'US', hsh
        end
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

    describe '#list' do
      subject { client.list 'Key', (1..10).to_a }

      it 'should use a dot notation' do
        1.upto(10).each do |count|
          should include "KeyList.Key.#{count}"
        end
      end
    end
  end
end
