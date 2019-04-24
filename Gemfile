source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.5.1'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.2.0'
# Use sqlite3 as the database for Active Record
#
gem 'mysql2'
# Use Puma as the app server
#
gem 'puma', '~> 3.11'
# Use SCSS for stylesheets
#
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
#
gem 'uglifier', '>= 1.3.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'mini_racer', platforms: :ruby

# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'

# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'

# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1.7'

# Use ActiveStorage variant
# gem 'mini_magick', '~> 4.8'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.1.0', require: false

# 异步队列。
gem 'sidekiq'

# 写入Linux中的crontab定时任务的一个ruby的DSL
gem 'whenever', require: false

# Ruby国际化和本地化的解决方案
gem 'i18n'
gem 'rails-i18n', '~> 5.0.3'

# redis相关的。 hiredis是一个高性能的redis两者结合用，和redis这个gem结合用。当您有大量回复（例如：lrange、smembers、zrange等）或使用大型管道时，最好使用hiredis。
# redis-rails是提供了完整的一套如(cache,session,http cache)等存储功能的包。如果rails是5.2及以上的版本，并且只需要使用片段缓存的话就不需要这个了，rails5.2已经有了。
# redis-namespace这个是可以让redis在配置文件中设置命名空间的gem包
gem 'hiredis', '~> 0.6.1'
gem 'redis', '~> 4.0.2'
gem 'redis-namespace'
gem 'redis-rails'

# 数据库初始数据相关。默认读取的是db/fixtures下的文件。
gem 'seed-fu'

# 能创造简单并且比较高级的搜索条件。
gem 'ransack', '~> 1.8.2'

# Kaminari是一个基于范围和引擎的、干净、强大、可自定义复杂条件的分页器。
gem 'kaminari', '~> 1.1.1'

# 使用yaml文件去安全地配置Rails应用程序，并且可以将配置存储在系统环境变量
gem 'figaro'

# rails中使用jquery
gem 'jquery-rails'

# 前端ui框架bootstrap
gem 'bootstrap', '~> 4.1.0'

# 更简单更强大的表单创建。
gem 'simple_form', '~> 4.0.0'

# 简化模板
# gem "haml-rails", "~> 2.0"
# gem 'slim-rails'

# 静态页面相关的gem
# gem 'high_voltage', '~> 3.0.0'

# 监控 数据库、redis、Cache、Sidekiq、Resque的状态的工具。
gem 'status-page'

# 拒绝低版本浏览器的访问，并给其返回一个让其升级的页面。
gem 'browser_warrior', '>= 0.8.0'

# 异常监控
gem 'exception_notification'
gem 'slack-notifier'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]

  # 开发环境中发邮件的时候不用发到真实的邮箱中了
  gem 'letter_opener'

  gem 'factory_bot_rails'
end

group :development do
  # web-console是RubyonRails应用程序的调试工具,报错的时候可以调试的。
  gem 'web-console', '>= 3.3.0'

  # 监听文件变动，并你去通知修改
  gem 'listen', '>= 3.0.5', '< 3.2'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  # 运行测试时，保持development在后台运行，不需要重启
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'

  # capistrano相关的gem
  gem 'capistrano', '~> 3.11', require: false
  gem 'capistrano-bundler', '~> 1.5', require: false
  gem 'capistrano-rails', '~> 1.4', require: false
  gem 'capistrano-rvm', require: false
  gem 'capistrano-sidekiq'
  gem 'capistrano3-puma'

  # 用于调试代码的一些工具
  gem 'pry'
  gem 'pry-byebug'
  gem 'pry-rails'
  gem 'pry-remote'

  # 友好且详尽的错误显示页面
  gem 'better_errors'
  gem 'binding_of_caller'
  # 性能分析工具
  gem 'rubycritic', require: false

  # 代码风格指南工具。具体使用,在根目录输入命令 rubocop -h 查看即可。 rubocop ./config/deploy
  gem 'rubocop', '~> 0.58.2', require: false
  gem 'rubocop-rspec', '~> 1.29', require: false

  # 检测你的gem使用情况。命令：  bundle exec derailed bundle:mem   使用derailed -h查看可用命令
  gem 'derailed'
  gem 'stackprof'
  gem 'derailed_benchmarks'

  # 一个文档生成工具
  gem 'yard', '>= 0.9.11'

  # 代码质量控制。使用命令： rails_best_practices . 分析。 -h帮助
  gem 'rails_best_practices'

  # model中自动生成数据表相关的文档。命令 rails g annotate:install 生成一个rake，之后db:migrate的时候会自动更新model中的文档了。
  # rake annotate_routes 该命令生成路由相关的文档
  gem 'annotate'

  # Chrome中的扩展，可以在Chrome开发者工具中查看如请求响应时间等的详细信息。
  gem 'meta_request'

  # 检查没有用到的routes。 执行命令 rake traceroute
  gem 'traceroute'

  # 语法漏洞检测工具。命令 brakeman  或者brakeman ./config/deploy.rb,具体的可用brakeman -h
  gem 'brakeman'

  # 帮助解决rails的N+1问题
  gem "bullet"
end

group :test do
  # 基于机架的Web应用程序的集成测试工具。它模拟用户如何与网站交互
  gem 'capybara', '>= 2.15'
  gem 'selenium-webdriver'

  # 可以更轻松地运行Selenium(浏览器自动测试框架)测试。
  gem 'webdrivers'

  # 清理数据库的策略。可用于确保测试的清洁状态。
  gem 'database_cleaner'

  gem 'launchy'
  # 提供“时间旅行”和“时间冻结”功能的gem，使测试依赖时间的代码变得非常简单。
  gem 'timecop'

  # 配置测试需要的数据
  gem 'webmock'

  # 单元测试
  gem 'rspec'
  gem 'rspec-core'
  gem 'rspec-expectations'
  gem 'rspec-mocks'
  gem 'rspec-rails'
  gem 'rspec-support'

  # 生成虚假数据
  gem "faker"

  # 模拟用户的行为，与html交互
  gem "selenium-webdriver"
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
