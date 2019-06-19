Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # Code is not reloaded between requests.
  config.cache_classes = true

  # Eager load code on boot. This eager loads most of Rails and
  # your application in memory, allowing both threaded web servers
  # and those relying on copy on write to perform better.
  # Rake tasks automatically ignore this option for performance.
  config.eager_load = true

  # Full error reports are disabled and caching is turned on.
  config.consider_all_requests_local       = false
  config.action_controller.perform_caching = true

  # Ensures that a master key has been made available in either ENV["RAILS_MASTER_KEY"]
  # or in config/master.key. This key is used to decrypt credentials (and other encrypted files).
  # config.require_master_key = true

  # Disable serving static files from the `/public` folder by default since
  # Apache or NGINX already handles this.
  # 如果是设置了nginx处理静态文件的话，这个地方就设置false即可。
  config.public_file_server.enabled = ENV['RAILS_SERVE_STATIC_FILES'].present?

  # Compress JavaScripts and CSS.设置静态资源的压缩方式,下面那种的支持es6语法的解析
  # config.assets.js_compressor = :uglifier
  config.assets.js_compressor = Uglifier.new(harmony: true)
  # 如果 Gemfile 中有 sass-rails，就会自动用来压缩 CSS，无需设置 config.assets.css_compressor 选项。
  # config.assets.css_compressor = :sass

  # Do not fallback to assets pipeline if a precompiled asset is missed.
  config.assets.compile = false

  # 是否压缩编译后的静态资源文件
  config.assets.compress = true

  # 在静态资源文件名中加入 MD5 指纹。
  config.assets.digest = true

  # `config.assets.precompile` and `config.assets.version` have moved to config/initializers/assets.rb

  # Enable serving of images, stylesheets, and JavaScripts from an asset server.
  # config.action_controller.asset_host = 'http://assets.example.com'

  # X-Sendfile 报头的作用是让服务器忽略程序的响应，直接从硬盘上伺服指定的文件。默认情况下服务器不会发送这个报头，但在支持该
  # 报头的服务器上可以启用。启用后，会跳过响应直接由服务器伺服文件，速度更快。
  # config.action_dispatch.x_sendfile_header = 'X-Sendfile' # for Apache
  config.action_dispatch.x_sendfile_header = 'X-Accel-Redirect' # for NGINX

  # Store uploaded files on the local file system (see config/storage.yml for options)
  config.active_storage.service = :local

  # Mount Action Cable outside main process or domain
  # config.action_cable.mount_path = nil
  # config.action_cable.url = 'wss://example.com/cable'
  # config.action_cable.allowed_request_origins = [ 'http://example.com', /http:\/\/example.*/ ]

  # Force all access to the app over SSL, use Strict-Transport-Security, and use secure cookies.
  # config.force_ssl = true

  # Use the lowest log level to ensure availability of diagnostic information
  # when problems arise.
  config.log_level = :debug

  # Prepend all log lines with the following tags.
  config.log_tags = [ :request_id ]

  # Use a different cache store in production.
  # 配置缓存的存储位置为redis,redis服务器总共可以设置16个数据库，如果没有设置默认是0
  config.cache_store = :redis_cache_store, CACHE_REDIS_CONFIG.merge({namespace: 'cache', compress: true})

  # 配置http缓存
  config.action_dispatch.rack_cache = {
    metastore: CACHE_REDIS_CONFIG.merge({namespace: 'metastore'}),
    entitystore: CACHE_REDIS_CONFIG.merge({namespace: 'entitystore'})
  }

  # Use a real queuing backend for Active Job (and separate queues per environment)
  # config.active_job.queue_adapter     = :resque
  # config.active_job.queue_name_prefix = "init_gems_#{Rails.env}"

  config.action_mailer.perform_caching = false

  # Ignore bad email addresses and do not raise email delivery errors.
  # Set this to true and configure the email server for immediate delivery to raise delivery errors.
  # config.action_mailer.raise_delivery_errors = false

  # Enable locale fallbacks for I18n (makes lookups for any locale fall back to
  # the I18n.default_locale when a translation cannot be found).
  config.i18n.fallbacks = true

  # Send deprecation notices to registered listeners.
  config.active_support.deprecation = :notify

  # Use default logging formatter so that PID and timestamp are not suppressed.
  config.log_formatter = ::Logger::Formatter.new

  # 设置一个全局字符串，作为数据表名的前缀。
  # config.active_record.table_name_prefix = rgt_

  # Use a different logger for distributed setups.
  # require 'syslog/logger'
  # config.logger = ActiveSupport::TaggedLogging.new(Syslog::Logger.new 'app-name')

  if ENV["RAILS_LOG_TO_STDOUT"].present?
    logger           = ActiveSupport::Logger.new(STDOUT)
    logger.formatter = config.log_formatter
    config.logger    = ActiveSupport::TaggedLogging.new(logger)
  end

  # Do not dump schema after migrations.
  config.active_record.dump_schema_after_migration = false


  # 配置email
  # 设置项说明
  # logger	运行邮件程序时生成日志信息。设为 nil 禁用日志。可设为 Ruby 自带的 Logger 或 Log4r 库。
  # smtp_settings	设置 :smtp 发送方式的详情。
  # sendmail_settings	设置 :sendmail 发送方式的详情。
  # raise_delivery_errors	如果邮件发送失败，是否抛出异常。仅当外部邮件服务器设置为立即发送才有效。
  # delivery_method	设置发送方式，可设为 :smtp（默认）、:sendmail、:file 和  :test。详情参阅 API 文档。
  # perform_deliveries	调用 deliver 方法时是否真发送邮件。默认情况下会真的发送，但在功能测试中可以不发送。
  # deliveries	把通过 Action Mailer 使用 :test 方式发送的邮件保存到一个数组中，协助单元测试和功能测试。
  # default_options	为 mail 方法设置默认选项值（:from，:reply_to 等）。

  config.action_mailer.delivery_method = :sendmail
  # Defaults to:
  # config.action_mailer.sendmail_settings = {
  #   location: '/usr/sbin/sendmail',
  #   arguments: '-i -t'
  # }
  config.action_mailer.perform_deliveries = true
  config.action_mailer.raise_delivery_errors = true
  config.action_mailer.default_options = {from: ENV['EMAIL_USER']}

  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
      address:              'smtp.163.com',
      port:                 25,
      domain:               'smtp.163.com',
      user_name:            ENV['EMAIL_USER'],
      password:             ENV['EMAIL_PASS'],
      authentication:       'login',
      enable_starttls_auto: true  }
end
