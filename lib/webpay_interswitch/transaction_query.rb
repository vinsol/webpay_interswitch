require 'net/http'
module WebpayInterswitch

  #################################################################################################
  ## This class can be used to fetch transaction details
  ## Initialization Parameters:
  ##
  ## post_params: Parameters sent via POST by the gateway at the redirect_url
  ## amount: This is needed to detect the masquerading or parameter tampering to alter the amount.
  ## WebpayInterswitch::TransactionQuery.new(params, amount)
  ##################################################################################################


  class TransactionQuery

    include WebpayInterswitch::Core

    # resp and desc are empty when transaction is successful
    # txnref is the unique number sent in request.
    # cardNum is always zero
    # apprAmt is always zero
    # response is populated when a transactions search query is sent.
    attr_accessor :txnref, :resp, :desc, :payRef, :retRef, :cardNum, :amount, :response

    TEST_URL = 'https://stageserv.interswitchng.com/test_paydirect/api/v1/gettransaction.json'

    def initialize(post_params={}, amount)
      post_params.to_hash.symbolize_keys!
      post_params.each_pair do |key, val|
        instance_variable_set("@#{key}", val)
      end
      @amount = amount
      fetch_response
    end

    ## fetches a returns a transaction as json
    def fetch_response
      uri              = URI.parse(make_request)
      http             = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl     = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE

      @response = JSON.parse http.get(uri.request_uri, { 'Hash' => sha_hash(string_for_get_query) }).body
    end

    ## Returns true or false
    def success?
      @response['ResponseCode'] == '00'
    end

    def full_error_message
      "#{ error_message }. #{ query_error_message }"
    end

    ## Returns error message if present. Else returns a blank string.
    ## This is generally due to incorrect parameters such as product_id, pay_item_id etc.
    def error_message
      @desc.strip.gsub(',', '')
    end

    ## Returns error message recd from the gateway if the txn query was failed.
    ## else, returns nil
    ## This is due to: incorrect amount, invalid card number etc.
    def query_error_message
      @response['ResponseDescription'] unless success?
    end

    def transaction_url
      TEST_URL
    end

    private

      def make_request
        url =  transaction_url
        url += "?productid=#{WebpayInterswitch::Gateway.product_id}"
        url += "&transactionreference=#{@txnref}"
        url += "&amount=#{@amount}"
      end

      ## Returns a string that is used to compute the sha hash for get transaction query on webpay.
      def string_for_get_query
        WebpayInterswitch::Gateway.product_id +
        @txnref.to_s +
        WebpayInterswitch::Gateway.mac_key
      end

  end
end