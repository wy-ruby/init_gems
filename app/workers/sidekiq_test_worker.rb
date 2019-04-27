# 配置sidekiq的处理任务的一个类，实际上使用该类处理队列任务的时候就是启动一个客户端去连接到sidekiq的服务端执行任务。
# 例如：可以在rails c中执行命令： Sidekiq::Client.push('queue' => 'default', 'class' => SidekiqTestWorker, 'args' => ['foo', 1, :bat => 'bar'])
# push方法主要是推送任务到redis中可以接受的参数是一个哈希，哈希里面包括有:
# queue - 对列名，默认为是：'default'
# class - 如果是设置的为执行的某个类的类名，如本类中的SidekiqTestWorker,那么其配置是使用该类中配置的。否则将用job类的
# args - 执行方法的简单参数数组必须是JSON-serializable
# at - 时间戳，必须是数字如：Time.now.to_f
# retry - 如果错误是否要重试，默认是
# backtrace - 是否保存错误回溯，可以配合配置的进入Dead区的时候的钩子，给自己发邮件通知。默认是： false。如果错误多的话就会造成redis占用过大。
# 注意所有选项必须要是字符串形式的，不能是symbols

class SidekiqTestWorker
  include Sidekiq::Worker
  # 配置sidekiq执行的对列名，重试次数
  # 如果您希望一个特定类型的作业只执行一次，不管发生什么。retry: false
  # retry:3, dead:false 重试三次后消失，不会进入UI中的那个dead区
  # sidekiq_options
  sidekiq_options queue: :critical, retry: 3, dead: false, backtrace: true

  # 配置重试多次失败后，在进入 Dead 区之前调用的钩子
  sidekiq_retries_exhausted do |msg, _ex|
    Sidekiq.logger.warn "Failed #{msg['class']} with #{msg['args']}: #{msg['error_message']}"
  end

  def perform(*args)
    # 传入数据后执行自己的逻辑
  end
end
