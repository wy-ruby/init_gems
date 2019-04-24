require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module InitGems
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
  end
end

read_config = YAML.load_file('config/redis.yml')
# 不使用hiredis
# REDIS_CONFIG = read_config[Rails.env].deep_symbolize_keys
# 使用hiredis。当有大量回复（例如：lrange、smembers、zrange等）或使用大型管道时，最好使用hiredis。
REDIS_CONFIG = read_config[Rails.env].deep_symbolize_keys.merge(:driver => :hiredis)
$redis = Redis.new(REDIS_CONFIG)

begin
  $redis.ping
rescue StandardError => e
  raise e.message
end