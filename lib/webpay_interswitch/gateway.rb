module WebpayInterswitch

  class MissingParameterError < StandardError; end
  class UnsupportedCurrencyError < StandardError; end

  class Gateway

    cattr_accessor :product_id, :pay_item_id, :currency, :site_redirect_url, :mac_key

    # Default currency to Naira
    @@currency = '566'

    TEST_URL = 'https://stageserv.interswitchng.com/test_paydirect/pay'

    LIVE_URL = 'https://stageserv.interswitchng.com/paydirect/pay'

    ## ACCEPTED_CURRENCIES:
    ## * Naira (In Kobo)

    ACCEPTED_CURRENCIES = ['566']

    def self.url
      TEST_URL
    end

    def self.setup
      yield self
    end

    def validate!
      requires!(:product_id, :pay_item_id, :currency, :site_redirect_url, :mac_key)
      validate_currency!
    end

    private

      def requires!(*required_parameters)
        required_parameters.each do |parameter|
          raise WebpayInterswitch::MissingParameterError if (self.public_send(parameter).blank?)
        end
      end

      def validate_currency!
        raise WebpayInterswitch::UnsupportedCurrencyError unless ACCEPTED_CURRENCIES.include?(@@currency.to_s)
      end
  end

end