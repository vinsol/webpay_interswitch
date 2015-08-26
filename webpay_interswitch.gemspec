$:.push File.expand_path('../lib', __FILE__)

require 'webpay_interswitch/version'

Gem::Specification.new do |s|
  s.name        = 'webpay_interswitch'
  s.version     = WebpayInterswitch::VERSION
  s.authors     = ['Shubham Gupta', 'Jitender Rai']
  s.email       = ['info@vinsol.com']
  s.homepage    = 'http://vinsol.com'
  s.files       = `git ls-files`.split($/)
  s.summary     = 'A simple gem to integrate your Rails app with Webpay Interswitch, a nigerian payment gateway'
  s.description = 'A simple gem to integrate Rails app with Webpay Interswitch, a nigerian payment gateway'
  s.license     = 'MIT'

  s.add_dependency('rails')
end
