require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Getart
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0
    
    config.hosts << /[a-z0-9]+\.ngrok\.io/
    
    #sidekiq configuration
    #config.active_job.queue_adapter = :sidekiq

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
  end
end
if File.exist?("#{Rails.root}/config/app_config.yml")
  AppConfig = Psych.safe_load(File.open("#{Rails.root}/config/app_config.yml"), aliases: true)
end