require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Datalympics
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
      config.i18n.default_locale = :fr
    config.load_defaults 5.2
    config.active_record.default_timezone = :utc
config.assets.paths << Rails.root.join("app", "assets", "fonts")

require Rails.root.join("lib/custom_public_exceptions")
    config.exceptions_app = CustomPublicExceptions.new(Rails.public_path)

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
  end
end
