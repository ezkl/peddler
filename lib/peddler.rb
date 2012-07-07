require 'forwardable'

require 'peddler/client'

module Peddler
  class << self
    extend Forwardable

    def_delegator Client, :new
  end
end
