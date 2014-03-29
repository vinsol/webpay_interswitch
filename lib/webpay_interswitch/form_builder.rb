module WebpayInterswitch
  class FormBuilder

    include WebpayInterswitch::Core

    def initialize(txn_ref, amount, html_options)
      @txn_ref = txn_ref
      @amount = amount
      @html_options = html_options
      sanitize_options
    end

    def generate_webpay_form
      form_html = "<form action=#{ WebpayInterswitch::Gateway.url } method=post>"

      form_html += generate_webpay_elements

      form_html += generate_transaction_data_elements

      # This generates the submit button alongwith the @submit_button_text
      # If submit_button_text is not provided, it defaults to 'Make Payment'
      form_html += generate_input_field('commit', @submit_button_text, 'submit', @html_options)

      form_html += '</form>'

    end

    def valid?
      @txn_ref.present? && Integer(@amount.to_s) > 0 rescue false
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

      # Generates the input tag alongwith the provided name, value, type and html_options if any.
      def generate_input_field(name, value, type = 'hidden', html_options={})
        html_string = string_for_html_options(html_options)
        "<input type=#{ type } name=#{ name } value='#{ value }' #{html_string}>"
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

      ## Returns a string from html_options that is embedded into the submit button.
      ## e.g: html_options = {id: 'hi', class: 'c1 c2'}
      ## output: "id='hi' class='c1 c2'"
      def string_for_html_options(html_options)
        html_string = ''
        html_options.each do |attr, val|
          html_string << " #{attr}='#{val}'"
        end
        html_string
      end

      def sanitize_options
        @html_options.symbolize_keys!
        @submit_button_text = @html_options.delete(:submit_button_text) || 'Make Payment'
      end

  end
end