module WebpayInterswitch
  module Generators
    class InstallGenerator < ::Rails::Generators::Base
      source_root File.expand_path("../../../../templates", __FILE__)

      def create_webpay_yml
        copy_file 'webpay_interswitch.yml.example', 'config/webpay_interswitch.yml.example'
      end

      def create_webpay_initializer
        copy_file 'webpay.rb', 'config/initializers/webpay.rb'
      end

    end
  end
end