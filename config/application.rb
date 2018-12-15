require_relative 'boot'

require 'rails/all'
require 'csv'
require 'open-uri'
require 'rack/proxy'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Farmally
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2

    config.i18n.available_locales = [:ja]
    config.i18n.enforce_available_locales = true
    config.i18n.default_locale = :ja

    config.time_zone = 'Tokyo'

    config.autoload_paths << Rails.root.join('lib')
    config.eager_load_paths << Rails.root.join('lib')

    config.generators.template_engine = :slim

    config.autoload_paths += %W(#{config.root}/app/forms)

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
  end
end
