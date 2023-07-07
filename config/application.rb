require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module GoRailsApi
  class Application < Rails::Application
    config.load_defaults 7.0
    config.autoload_paths << Rails.root.join('lib')
    config.time_zone = 'UTC'
    config.active_job.queue_adapter = :sidekiq
  end
end
