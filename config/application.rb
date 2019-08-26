require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module SlackApp
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
<<<<<<< HEAD
    config.time_zone = "Rangoon"
    config.active_record.default_timezone = :local
=======
    
>>>>>>> ae6d9934d9f0c5205c5093f474a9778c79702a79
  end
end
