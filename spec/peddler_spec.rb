require 'spec_helper'

describe Peddler do
  describe '.new' do
    it 'should delegate to Client' do
      Peddler::Client.should_receive :new
      Peddler.new
    end
  end
end
