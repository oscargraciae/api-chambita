Rails.application.configure do

  Paperclip.options[:content_type_mappings]

  config.cache_store = :dalli_store

  # Settings specified here will take precedence over those in config/application.rb.
  # Paperclip.options[:command_path] = 'C:\Program%20Files%20(x86)\GnuWin32\bin'
  Paperclip.options[:command_path] = 'C:\Program Files\ImageMagick-6.9.3-Q16'
  Paperclip.options[:swallow_stderr] = false
  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false


  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports and disable caching.
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = true

  # Don't care if the mailer can't send.
  config.action_mailer.raise_delivery_errors = false

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }

  # Raise an error on page load if there are pending migrations.
  config.active_record.migration_error = :page_load

  # Debug mode disables concatenation and preprocessing of assets.
  # This option may cause significant delays in view rendering with a large
  # number of complex assets.
  config.assets.debug = true

  # Asset digests allow you to set far-future HTTP expiration dates on all assets,
  # yet still be able to expire them through the digest params.
  config.assets.digest = true

  # Adds additional error checking when serving assets at runtime.
  # Checks for improperly declared sprockets dependencies.
  # Raises helpful error messages.
  config.assets.raise_runtime_errors = true

  config.after_initialize do
    Bullet.enable = true
    Bullet.alert = true
    Bullet.bullet_logger = true
    #Bullet.console = true
    Bullet.rails_logger = true
    #Bullet.airbrake = true
  end
#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
  ActionMailer::Base.smtp_settings = {
    :user_name => 'ogracia',
    :password => 'Ogracia#001',
    :domain => 'chambita.mx',
    :address => 'smtp.sendgrid.net',
    :port => 587,
    :authentication => :plain,
    :enable_starttls_auto => true
  }

  # Raises error for missing translations
  # config.action_view.raise_on_missing_translations = true
end
