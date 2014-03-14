module WebpayInterswitch
  module ViewHelper

    def form_for_webpay(txn_ref, amount, submit_button_text='Make Payment')
      form_builder = WebpayInterswitch::FormBuilder.new(txn_ref, amount)
    begin
      WebpayInterswitch::Gateway.new.validate!
      form_builder.generate_webpay_form(submit_button_text).html_safe if form_builder.valid?
    rescue => e
      p e
    end
    end

  end
end