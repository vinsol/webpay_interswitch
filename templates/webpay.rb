## This should be placed at config/initializers of your Rails app.

WebpayInterswitch::Gateway.setup do |config|

  gateway_attrs = YAML.load_file(File.join("#{Rails.root}", 'config', 'webpay_interswitch.yml'))['webpay'][Rails.env].symbolize_keys!
  config.product_id = gateway_attrs[:product_id]
  config.pay_item_id = gateway_attrs[:pay_item_id]
  config.currency = gateway_attrs[:currency]
  config.site_redirect_url = gateway_attrs[:site_redirect_url]
  config.mac_key = gateway_attrs[:mac_key]

end