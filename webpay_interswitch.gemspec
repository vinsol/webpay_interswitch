$:.push File.expand_path('../lib', __FILE__)

require 'webpay_interswitch/version'

Gem::Specification.new do |s|
  s.name        = 'webpay_interswitch'
  s.version     = WebpayInterswitch::VERSION
  s.authors     = ['Shubham Gupta']
  s.email       = ['sgupta.89cse@gmail.com']
  s.homepage    = 'https://github.com/ShubhamGupta/webpay_interswitch'
  s.files       = Dir["{lib,spec}/**/*", '[A-Z]*']
  s.summary     = 'A simple gem to integrate your Rails app with Webpay Interswitch'
  s.description = 'A simple gem to integrate your Rails app with Webpay Interswitch'

  s.add_dependency('rails')
end
