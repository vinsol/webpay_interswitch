$:.push File.expand_path('../lib', __FILE__)

require 'webpay_interswitch/version'

Gem::Specification.new do |s|
  s.name        = 'webpay_interswitch'
  s.version     = WebpayInterswitch::VERSION
  s.authors     = ['Shubham Gupta']
  s.email       = ['sgupta.89cse@gmail.com']
  s.homepage    = 'http://vinsol.com'
  s.files       = Dir["{lib,spec,vendor}/**/*", '[A-Z]*'] - ['Gemfile.lock']
  s.summary     = 'A simple gem to integrate your Rails app with Webpay Interswitch'
  s.description = 'Add description here'

  s.add_dependency('rails')
end
