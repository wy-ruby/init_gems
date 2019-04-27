# 注意配置redis的时候最好使用一个单独的redis数据库去存储sidekiq中的数据。
# 执行命令：rails g sidekiq:worker SidekiqTest  在app/workers目录下已经生成一个处理类的例子。

# 配置sidekiq的服务端
# 可以配置服务端中间件，具体可参考文档。
Sidekiq.configure_server do |config|
  config.redis = SIDEKIQ_REDIS_CONFIG
  # 从sidekiq的5.1版本之后，新增的配置任务进入Dead区的时候的通知。
  # 有了这个回调，你可以给自己发电子邮件，发送一条空闲消息等，这样你就知道有什么问题。
  #   config.death_handlers << ->(job, ex) do
  #     puts "Uh oh, #{job['class']} #{job["jid"]} just died with error #{ex.message}."
  #   end
  config.death_handlers << ->(job, ex) do
    puts "Uh oh, #{job['class']} #{job['jid']} just died with error #{ex.message}."
  end

  # 配置sidekiq检查任务的时间间隔。如果不设置默认是5秒
  config.average_scheduled_poll_interval = 10

  # 可以自定义配置日志，例如：
  # config.options[:job_logger] = MyJobLogger
end

# 配置自定义的日志的格式等信息。
# class MyJobLogger < Sidekiq::JobLogger
#   def call(item, queue)
#     #
#     # Optionally add context to all log lines of a given job, in addition to
#     # Sidekiq’s default “TID-xxx JID-yyy” context.
#     #
#     Sidekiq::Logging.with_context("source=#{item['class']}") do
#       begin
#         start = Time.now
#         logger.info('start')
#         yield
#         logger.info("count#job.success=1 measure#job.duration=#{elapsed(start)}s")
#       rescue Exception
#         logger.info("count#job.failure=1 measure#job.duration=#{elapsed(start)}s")
#         raise
#       end
#     end
#   end
# end

# 配置sidekiq的客户端。
# 在执行作业之前，如果需要设置一些全局状态（例如，当前区域设置、多租户应用程序中的当前租户）可以
# 配置客户端中间件，中间件的执行是在把job推送到redis之前执行的。
#
Sidekiq.configure_client do |config|
  config.redis = SIDEKIQ_REDIS_CONFIG
end
