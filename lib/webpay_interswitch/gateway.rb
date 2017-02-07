module WebpayInterswitch

  class MissingParameterError < StandardError; end
  class UnsupportedCurrencyError < StandardError; end

  class Gateway

    cattr_accessor :product_id, :pay_item_id, :currency, :site_redirect_url, :mac_key, :test

    TEST_URL = 'https://sandbox.interswitchng.com/webpay/pay'

    LIVE_URL = 'https://webpay.interswitchng.com/paydirect/pay'

    ## ACCEPTED_CURRENCIES:
    ## * Naira (In Kobo)

    ACCEPTED_CURRENCIES = ['566']

    def self.url
      WebpayInterswitch::Gateway.test ? TEST_URL : LIVE_URL
    end

    def self.setup
      yield self
      set_defaults!
    end

    def validate!
      requires!(:product_id, :pay_item_id, :currency, :site_redirect_url, :mac_key)
      validate_currency!
    end

    private

      def self.set_defaults!
        # Default currency to Naira (Kobo)
        @@currency ||= '566'

        ## Default test to true.
        ## Set this to false explicitly only in production environment.
        @@test ||= false
      end

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