# Puma can serve each request in a thread from an internal thread pool.
# The `threads` method setting takes two numbers: a minimum and maximum.
# Any libraries that use thread pools should be configured to match
# the maximum value specified for Puma. Default is set to 5 threads for minimum
# and maximum; this matches the default thread size of Active Record.
#
# 详细的配置方法可以看 https://github.com/puma/puma/blob/master/examples/config.rb

# if ENV['RAILS_ENV'] == 'production'
#   app_root = '/root/live/init_gems/shared'
#   pidfile "#{app_root}/tmp/pids/puma.pid"
#   state_path "#{app_root}/tmp/pids/puma.state"
#   bind "unix://#{app_root}/tmp/sockets/puma.sock"
#   activate_control_app "unix://#{app_root}/tmp/sockets/pumactl.sock"
#   port 3002
#
#   # 守护进程
#   daemonize true
#
#   # 要运行多少工作进程。通常设置为到可用内核的数量。
#   workers 2
#
#   # 配置最小及最大线程数
#   threads 8, 16
#
#   # 标准输出日志以及错误日志
#   stdout_redirect "#{app_root}/log/puma_access.log", "#{app_root}/log/puma_error.log", true
#
#   prune_bundler
# end

root_path = '/Users/poly/www/ruby/init_gems'

# pid保存的目录
pidfile "#{root_path}/tmp/pids/puma.pid"

# 服务器状态
state_path "#{root_path}/tmp/pids/puma.state"

port        ENV.fetch("PORT") { 3000 }