require 'jeff'

require 'peddler/mws/products'

module Peddler
  # A client to Amazon Marketplace Web Service (MWS) APIs.
  class Client
    include Jeff

    BadLocale     = Class.new ArgumentError
    MissingSeller = Class.new ArgumentError

    HOSTS = {
      'CA' => 'mws.amazonservices.ca',
      'CN' => 'mws.amazonservices.com.cn',
      'DE' => 'mws-eu.amazonservices.com',
      'ES' => 'mws-eu.amazonservices.com',
      'FR' => 'mws-eu.amazonservices.com',
      'IN' => 'mws.amazonservices.in',
      'IT' => 'mws-eu.amazonservices.com',
      'JP' => 'mws.amazonservices.jp',
      'UK' => 'mws-eu.amazonservices.com',
      'US' => 'mws.amazonservices.com'
    }

    # TODO: Fill missing values.
    MARKETPLACES = {
      'CA' => nil,
      'CN' => nil,
      'DE' => 'A1PA6795UKMFR9',
      'ES' => 'A1RKKUPIHCS9HS',
      'FR' => 'A13V1IB3VIYZZH',
      'IN' => nil,
      'IT' => 'APJ6JRA9NG5V4',
      'JP' => nil,
      'UK' => 'A1F83G8C2ARO7P',
      'US' => 'ATVPDKIKX0DER'
    }

    # Creates a client.
    #
    # locale - A String locale key.
    def initialize(locale)
      self.endpoint = "https://#{HOSTS[@locale = locale] or raise BadLocale}"
    end

    # Configures the credentials of the endpoint.
    #
    # hsh - The Hash credentials of the endpoint (default: nil).
    #      :key    - The String AWS access key id.
    #      :secret - The String AWS access secret key.
    #      :seller - The String seller id.
    #
    # Yields self if a block is given.
    #
    # Returns nothing.
    def configure(hsh = nil, &blk)
      if block_given?
        yield self
      else
        hsh.each { |k, v| __send__ "#{k}=", v }
      end
    end

    # Internal: Gets the String marketplace id for given or current locale.
    #
    # locale - A String locale name (default: nil).
    def marketplace(locale = nil)
      MARKETPLACES[locale || @locale]
    end

    # Internal: Gets the String seller id.
    #
    # Raises a MissingSeller error if value is missing.
    def seller
      @seller or raise MissingSeller
    end

    # Sets the String seller id.
    attr_writer :seller

    # Define getters for the APIs.
    %w(products).each do |api|
      eval <<-DEF
        def #{api}
          @#{api} ||= begin
            MWS::#{api.split('_').map { |w| w.capitalize }.join}.new self
          end
        end
      DEF
    end
  end
end
