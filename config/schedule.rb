# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever
# 可以这样设置全局执行日志
# set :output, {:error => 'log/cron_error.log', :standard => 'cron_access.log'}
set :output, File.expand_path(File.dirname(__FILE__) + "/../log/cron_log.log")

every '* * * * *' do
  rake 'practice:whenever_test'
  command "echo 'you can use raw cron syntax too'"
end

every :day, at: '5:30pm', roles: [:app] do
  command "echo '每天运行的，在roles角色为：app下进行的'"
end

every 1.minute, roles: [:db] do
  command "echo '每分钟运行的，在roles角色为：db下进行的。'"
end

every 1.minute do
  command "echo '每分钟运行的'"
end
