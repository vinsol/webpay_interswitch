require 'webpay_interswitch/view_helper.rb'
require 'webpay_interswitch/core.rb'
require 'webpay_interswitch/form_builder.rb'
require 'webpay_interswitch/gateway.rb'
require 'webpay_interswitch/transaction_query.rb'
require 'webpay_interswitch/version.rb'

ActionView::Base.send(:include, WebpayInterswitch::ViewHelper) if defined?(::Rails)