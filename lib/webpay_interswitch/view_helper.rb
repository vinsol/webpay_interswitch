module WebpayInterswitch
  module ViewHelper

    def form_for_webpay(txn_ref, amount, html_options={}, optional_parameters={})
      form_builder = WebpayInterswitch::FormBuilder.new(txn_ref, amount, html_options, optional_parameters)
      WebpayInterswitch::Gateway.new.validate!
      form_builder.generate_webpay_form.html_safe if form_builder.valid?
    end

  end
end