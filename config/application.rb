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

    # active job设置队列后台连接器，配置成sidekiq的。
    config.active_job.queue_adapter = :sidekiq

    # 如加入对面名前缀和连接前缀后对列名变成了 development.queue_name
    # 设置任务队列名称的前缀。
    config.active_job.queue_name_prefix = Rails.env
    # 默认队列名称的连接前缀是 _
    config.active_job.queue_name_delimiter = '.'

  end
end

# 获取redis的配置信息。
read_config = YAML::load(ERB.new(IO.read('config/redis.yml')).result)

# 不使用hiredis
# REDIS_CONFIG = read_config[Rails.env].deep_symbolize_keys
# SIDEKIQ_REDIS_CONFIG = sidekiq_config.deep_symbolize_keys
# 使用hiredis。当有大量回复（例如：lrange、smembers、zrange等）或使用大型管道时，最好使用hiredis。
# cache、session、http片段缓存用一个单独的redis数据库(编号为2)来保存数据，
# sidekiq用一个单独的redis数据库(编号为1)，其他的信息再用一个单独的数据库(编号为默认数据看库0)。
REDIS_CONFIG = read_config[Rails.env].deep_symbolize_keys.merge(:driver => :hiredis)
CACHE_REDIS_CONFIG = REDIS_CONFIG.merge(:db => 2)
SIDEKIQ_REDIS_CONFIG = REDIS_CONFIG.merge(:db => 1)
Rails.logger.info "-----CACHE_REDIS_CONFIG:--------#{CACHE_REDIS_CONFIG}---------------"
p "-----SIDEKIQ_REDIS_CONFIG:--------#{SIDEKIQ_REDIS_CONFIG}---------------"