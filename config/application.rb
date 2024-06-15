

require 'uri'
require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

# Include middleware
require './lib/middleware/bad_multipart_form_data_sanitizer'

module Ozfortress
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.0

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    # Make view helpers, view specific
    config.action_controller.include_all_helpers = false

    # Use dynamic error pages
    config.exceptions_app = self.routes

    # News config file
    config.news = config_for(:news)

    # config.middleware.use 'BadMultipartFormDataSanitizer'
    config.middleware.insert_before Rack::Runtime, BadMultipartFormDataSanitizer
  end
end
