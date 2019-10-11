require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module TascPepperjam
  class Application < Rails::Application
    require 'json'
    require 'openssl'
    require 'nokogiri'
    require 'open-uri'
    require 'base64'
    require 'csv'
    require 'net/ftp'
    require 'ext/order_csv'
    require 'tempfile'
    require 'ext/colorize'

    # Do not swallow errors in after_commit/after_rollback callbacks.
    config.active_record.raise_in_transactional_callbacks = true

    ShopifyAPI::Base.site = "https://#{ENV["API_KEY"]}:#{ENV["PASSWORD"]}@tasc-dev.myshopify.com/admin"
  end
end
