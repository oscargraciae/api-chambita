require File.expand_path('../boot', __FILE__)

#API CONEKTA
require "conekta"
require 'rails/all'


# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)


module Chambitas
  class Application < Rails::Application
<<<<<<< HEAD
    require 'extend_string'
=======
    #require 'extend_string'

>>>>>>> 9a586669303e5e3ed3e71223068da6087df964fe
    Conekta.api_key = 'key_jaiWQwqGqEkQqqkUqhdy2A'
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    config.time_zone = 'Monterrey'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    # Do not swallow errors in after_commit/after_rollback callbacks.
    config.active_record.raise_in_transactional_callbacks = true

    config.paperclip_defaults = {
        :storage => :s3,
        :s3_credentials => {
            :access_key_id => 'AKIAJE2VWUVEX5WUBB5Q',
            :secret_access_key => '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',
            :bucket => 'chambita1236'
        }
    }

  end
end
