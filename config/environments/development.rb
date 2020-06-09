Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports.
  config.consider_all_requests_local = true

  # Enable/disable caching. By default caching is disabled.
  # 运行命令： rails dev:cache 可以开启文件缓存。
  if Rails.root.join('tmp', 'caching-dev.txt').exist?
    config.action_controller.perform_caching = true

    config.cache_store = :memory_store
    config.public_file_server.headers = {
      'Cache-Control' => "public, max-age=#{2.days.to_i}"
    }
  else
    config.action_controller.perform_caching = true
    # config.cache_store = :null_store
    # config.cache_store = :redis_cache_store, CACHE_REDIS_CONFIG.merge({namespace: 'cache', compress: true, expires_in: 10.minutes})
    config.cache_store = :redis_store, "redis://localhost:6379/2/cache", { expires_in: 90.minutes }
    # config.cache_store = :redis_cache_store, {driver: :hiredis, namespace: 'cache', compress: true,
    #                                           timeout: 1, url: "redis://127.0.0.1:6379/2"}
  end

  # 配置http缓存
  redis_password = CACHE_REDIS_CONFIG[:password].present? ? ":#{CACHE_REDIS_CONFIG[:password]}@": ""
  metastore_redis_config = "redis://#{redis_password}#{CACHE_REDIS_CONFIG[:host]}:#{CACHE_REDIS_CONFIG[:port]}/#{CACHE_REDIS_CONFIG[:db]}/metastore"
  entitystore_redis_config = "redis://#{redis_password}#{CACHE_REDIS_CONFIG[:host]}:#{CACHE_REDIS_CONFIG[:port]}/#{CACHE_REDIS_CONFIG[:db]}/entitystore"
  config.action_dispatch.rack_cache = {
    metastore: metastore_redis_config,
    entitystore: entitystore_redis_config
  }

  # Store uploaded files on the local file system (see config/storage.yml for options)
  config.active_storage.service = :local

  # Don't care if the mailer can't send.
  config.action_mailer.raise_delivery_errors = false

  config.action_mailer.perform_caching = false

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations.
  config.active_record.migration_error = :page_load

  # Highlight code that triggered database queries in logs.
  config.active_record.verbose_query_logs = true

  # Debug mode disables concatenation and preprocessing of assets.
  # This option may cause significant delays in view rendering with a large
  # number of complex assets.
  config.assets.debug = true

  # Suppress logger output for asset requests.
  config.assets.quiet = true

  # Raises error for missing translations
  # config.action_view.raise_on_missing_translations = true

  # Use an evented file watcher to asynchronously detect changes in source code,
  # routes, locales, etc. This feature depends on the listen gem.
  config.file_watcher = ActiveSupport::EventedFileUpdateChecker

  # 设为 true，启用额外的运行时错误检查。建议在 config/environments/development.rb 中设置，这样可以尽量减少部署到生产环境后的异常表现。
  config.assets.raise_runtime_errors = true

  # 设置执行 rails console 命令时使用哪个类实现控制台，最好在 console 代码块中设置,并且只有在运行控制台时才调用此块。
  console do
    # this block is called only when running console,
    # so we can safely require pry here
    require "pry"
    config.console = Pry
  end

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
  config.action_mailer.default_options = {from: Rails.application.credentials[:email_user]}

  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
      address:              'smtp.163.com',
      port:                 25,
      domain:               'smtp.163.com',
      user_name:            Rails.application.credentials[:email_user],
      password:             Rails.application.credentials[:email_pass],
      authentication:       'login',
      enable_starttls_auto: true  }

  # 在本地预编译一定不能运行 Capistrano 部署任务来预编译静态资源,并且要修改下面的配置(默认是/assets文件夹)；
  config.assets.prefix = "/dev-assets"

  # devise这个gem的配置，注意不同的环境配置内容是不同的。
  config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }

  # 配置 lograge 的支持。一般是在生产环境下配置的。日志是保存在 #{Rails.env}.log 中。
  config.lograge.enabled = true
  # 可以添加自定义内容。
  config.lograge.custom_options = lambda do |event|
    { time: Time.now.strftime("%Y-%m-%d %H:%M:%S"), host: event.payload[:host]}
  end
  # 可以添加一个钩子以直接访问控制器方法（例如request和current_user）。 该哈希将自动合并到日志数据中。
  config.lograge.custom_payload do |controller|
    {
        protocol: controller.request.protocol.match(/([a-zA-Z]*)/)[0].to_s
    }
  end
  # 保持rails原本的日志信息
  # config.lograge.keep_original_rails_log = true
  # config.lograge.logger = ActiveSupport::Logger.new "#{Rails.root}/log/lograge_#{Rails.env}.log"

  # 为了进一步清理日志，您还可以告诉Lograge跳过满足给定条件的日志消息。您可以跳过某些控制器操作生成的日志消息，也可以编写自定义处理程序以根据
  # 日志事件中的数据跳过消息：
  # config.lograge.ignore_actions = ['HomeController#index', 'AController#an_action']
  # config.lograge.ignore_custom = lambda do |event|
  #   return true here if you want to ignore based on the event
  # end

  # Lograge支持多种输出格式。 最常见的是上述默认Lograge键值格式。 另外，您还可以生成Logstash使用的json_event格式的JSON日志。
  # 使用logstash输出时，需要添加  gem logstash-event
  config.lograge.formatter = Lograge::Formatters::Logstash.new
  # 可用的日志格式有：
  # Lograge::Formatters::Lines.new
  # Lograge::Formatters::Cee.new
  # Lograge::Formatters::Graylog2.new
  # Lograge::Formatters::KeyValue.new  # lograge 的默认格式
  # Lograge::Formatters::Json.new
  # Lograge::Formatters::Logstash.new
  # Lograge::Formatters::LTSV.new
  # Lograge::Formatters::Raw.new       # 返回一个ruby的哈希对象
  # 除了格式化程序，您还可以通过传递一个响应#call的对象来自己操作数据：
  # config.lograge.formatter = ->(data) { "Called #{data[:controller]}" } # data is a ruby hash


end
