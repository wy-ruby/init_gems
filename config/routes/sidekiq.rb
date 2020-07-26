# 注意该路由(/sidekiq/stats)可以看到json格式sidekiq的一些状态信息。
require 'sidekiq/web'

# 配置sidekiq ui登录的权限，更高级配置可以看文档。
Sidekiq::Web.use Rack::Auth::Basic do |username, password|
  ActiveSupport::SecurityUtils.secure_compare(::Digest::SHA256.hexdigest(username.to_s), ::Digest::SHA256.hexdigest('admin')) &
      ActiveSupport::SecurityUtils.secure_compare(::Digest::SHA256.hexdigest(password.to_s), ::Digest::SHA256.hexdigest('123456'))
end
mount Sidekiq::Web => '/sidekiq'

# 如果提交表单的时候返回了一个Forbidden错误的话，在rails5.2及以上的版本中进行这样配置。
Sidekiq::Web.set :session_secret, Rails.application.credentials[:secret_key_base]

# 如果使用ui的时候session被覆盖重写的话，添加这行命令。
Sidekiq::Web.set :sessions, false

# 使用该api后可以通过路由/queue-status去查询'default'队列积压的情况。如果响应为“uhoh”，就会触发一封电子邮件。
require 'sidekiq/api'
match "queue-status" => proc { [200, {"Content-Type" => "text/plain"}, [Sidekiq::Queue.new.size < 100 ? "OK" : "UHOH" ]] }, via: :get
