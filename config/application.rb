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

    # 如加入对面名前缀和连接前缀后对列名变成了 development_queue_name
    # 设置任务队列名称的前缀。
    config.active_job.queue_name_prefix = Rails.env
    # 默认队列名称的连接前缀是"_",可以使用下面的方法修改。
    # config.active_job.queue_name_delimiter = '.'

    # 配置i18n的默认语言
    config.i18n.default_locale = "zh-CN"

    # 添加一个中间件，这个是处理i18n的区域设置的时候，根据用户的语言偏好获取http首部。使用rack-contrib gem。
    config.middleware.use Rack::Locale

    # rails应用如果版本大于5.1默认使用这个，注释即可，否则需要启用。使用rack-attack gem。
    # config.middleware.use Rack::Attack

    # 配置数据库的时间以及 +Rails+ 显示的时间都为本地时区的时间。
    # time_zone 配置的作用，是在 ActiveRecord 中取时间的时候，将 UTC 时间转换成 Local 时间，也就是通过 created_at 等方法获取到的将
    # 直接是转换后的 Local 时间，当然如果本身存储在 DB 中的时间就是 Local 时间那么就不转换。存储在 DB 中的时间仍然是 UTC 时间，要想更改
    # 这个存储在 DB 中的时间需要配置下面的 default_timezone 选项。
    # 对于中国地区来说，该选项设置成 Beijing 就可以了。
    config.time_zone = 'Beijing'
    # 这个 default_timezone 是决定 active_record 对数据库交互的时区设置，也就是影响 created_at 和 updated_at 在数据库的记录时间。
    # 只有两个参数:utc 和:local，rails 初始化时默认是 utc，所以保存到数据库的时间是 utc 时间。
    config.active_record.default_timezone = :local
  end
end

# 获取redis的配置信息。
read_config = YAML::load(ERB.new(IO.read('config/redis.yml')).result)

# 不使用hiredis，把.merge(:driver => :hiredis)去掉即可
# REDIS_CONFIG = read_config[Rails.env].symbolize_keys
# 使用hiredis。当有大量回复（例如：lrange、smembers、zrange等）或使用大型管道时，最好使用hiredis。
# cache、session、http片段缓存用一个单独的redis数据库(编号为2)来保存数据，
# sidekiq用一个单独的redis数据库(编号为1)，其他的信息再用一个单独的数据库(编号为默认数据看库0)。
REDIS_CONFIG = read_config[Rails.env].symbolize_keys.merge(:driver => :hiredis)
CACHE_REDIS_CONFIG = REDIS_CONFIG.merge(:db => 2)
SIDEKIQ_REDIS_CONFIG = REDIS_CONFIG.merge(:db => 1)