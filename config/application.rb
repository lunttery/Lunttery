require_relative 'boot'

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "action_cable/engine"
require "sprockets/railtie"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Lunttery
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    config.autoload_paths += %W(#{config.root}/app/uploaders)

    config.time_zone = "Taipei"

    RGeo::ActiveRecord::SpatialFactoryStore.instance.tap do |config|
      # By default, use the GEOS implementation for spatial columns.
      config.default = RGeo::Geos.factory_generator

      # But use a geographic implementation for point columns.
      config.register(RGeo::Geographic.spherical_factory(srid: 4326), geo_type: "point")
    end
  end
end
