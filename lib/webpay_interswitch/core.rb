module WebpayInterswitch
  module Core

    ## Returns the sha hash to be sent to webpay with params for querying or making payment.
    def sha_hash(message='')
      Digest::SHA512.hexdigest(message)
    end

  end
end