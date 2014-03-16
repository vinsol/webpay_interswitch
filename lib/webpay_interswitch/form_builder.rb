module WebpayInterswitch
  class FormBuilder

    include WebpayInterswitch::Core

    def initialize(txn_ref, amount)
      @txn_ref = txn_ref
      @amount = amount
    end

    def generate_webpay_form(submit_button_text)
      form_html = "<form action=#{ WebpayInterswitch::Gateway.url } method=post>"
      
      form_html += generate_webpay_elements

      form_html += generate_transaction_data_elements

      form_html += generate_input_field('commit', submit_button_text, 'submit')

      form_html += '</form>'

    end

    def valid?
      @txn_ref.present? && Integer(@amount) > 0 rescue false
    end

    private

      def generate_webpay_elements
        webpay_elem_html = ''
        %w(product_id pay_item_id currency site_redirect_url).each do |field_name|
          webpay_elem_html += generate_input_field(field_name, WebpayInterswitch::Gateway.public_send("#{ field_name }"))
        end
        webpay_elem_html
      end

      def generate_transaction_data_elements
        txn_elem_html  = generate_input_field('txn_ref', @txn_ref)
        txn_elem_html += generate_input_field('amount', @amount)
        txn_elem_html += generate_input_field('hash', sha_hash(string_for_hash_param))
      end

      def generate_input_field(name, value, type = 'hidden')
        "<input type=#{ type } name=#{ name } value='#{ value }'>"
      end

      ## Returns a string that is used to compute the sha hash for POST request on webpay.
      def string_for_hash_param
        @txn_ref.to_s +
        WebpayInterswitch::Gateway.product_id +
        WebpayInterswitch::Gateway.pay_item_id +
        @amount.to_s +
        WebpayInterswitch::Gateway.site_redirect_url +
        WebpayInterswitch::Gateway.mac_key
      end

  end
end