source 'https://gems.ruby-china.com'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.5.1'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.2.0'

# Use mysql2 as the database for Active Record
gem 'mysql2'

# Use Puma as the app server
gem 'puma', '~> 3.12'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'mini_racer', platforms: :ruby

# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'

# Turbolinks
# 详情参考链接: https://github.com/turbolinks/turbolinks 或者参考docs/Turbolinks.md
gem 'turbolinks', '~> 5'

# 使用生成器生成JSON对象，常见如views/**/xxx.json.jbuilder文件 .详细见: /docs/Jbuilder.md
gem 'jbuilder', '~> 2.5'

# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1.7'

# 处理跨域问题
# gem 'rack-cors'

# Use ActiveStorage variant
# gem 'mini_magick', '~> 4.8'

# Reduces boot times through caching; required in config/boot.rb
# 使用缓存的方式加快rails应用的启动速度。缓存到tmp/cache目录下，一般是该目录下的bootsnap*文件夹
gem 'bootsnap', '>= 1.1.0', require: false

# 是用于编译和服务assets的Ruby库
gem 'sprockets', '~> 3.0'

# 异步队列。
gem 'sidekiq'

# 写入Linux中的crontab定时任务的一个ruby的DSL
gem 'whenever', require: false

# Ruby国际化和本地化的解决方案
gem 'i18n'
gem 'rails-i18n', '~> 5.0.3'

# redis相关的。 hiredis是一个高性能的redis两者结合用，和redis这个gem结合用。当您有大量回复（例如：lrange、smembers、zrange等）或使用大型管道时，最好使用hiredis。
# redis-rails和redis-rack-cache是提供了完整的一套如(cache,session,http cache)等存储功能的包。如果rails是5.2及以上的版本，并且只需要使用片段缓存的话就不需要这个了，rails5.2已经有了。
# redis-namespace这个是可以让redis在配置文件中设置命名空间的gem包
gem 'hiredis', '~> 0.6.1'
gem 'redis', '~> 4.0.2'
gem 'redis-namespace'

gem 'redis-rails'
gem 'redis-rack-cache'

# 数据库初始数据相关。默认读取的是db/fixtures下的文件。
gem 'seed-fu'

# 能创造简单并且比较高级的搜索条件。
# gem 'ransack', '~> 1.8.2'

# Kaminari是一个基于范围和引擎的、干净、强大、可自定义复杂条件的分页器。
# gem 'kaminari', '~> 1.1.1'

# 使用yaml文件去安全地配置Rails应用程序，并且可以将配置存储在系统环境变量
gem 'figaro'

# 上传组件
# gem "carrierwave"

# rails中使用jquery
# gem 'jquery-rails'

# 前端ui框架bootstrap
gem 'bootstrap', '~> 4.3.0'
# gem 'webpacker'

# 更简单更强大的表单创建。
# gem 'simple_form', '~> 4.0.0'

# 简化模板
# gem "haml-rails", "~> 2.0"
# gem 'slim-rails'

# 静态页面相关的gem
# gem 'high_voltage', '~> 3.0.0'

# 验证码，头像
# gem "letter_avatar"
# gem "rucaptcha"

# 监控 数据库、redis、Cache、Sidekiq、Resque的状态的工具。
# gem 'status-page'

# paper_trail 跟踪对模型的更改，以进行审核或版本控制。
# gem 'paper_trail'

# elasticsearch中的apm瓶颈监控工具
# gem 'elastic-apm'
# gem "elasticsearch-model"
# gem "elasticsearch-rails"
# 配套 es 的使用的搜索工具
# gem 'searchkick'

# 用户系统
gem "devise"
gem "devise-encryptable"

# 可以为我们的应用加入操作权限控制。
gem "pundit"
# 搭配devise、pundit使用，添加role对权限更加精细化的操作，比如实现RBAC权限管理。
gem "rolify"
# 权限管理这一块或者可以使用下面的这个
# gem "cancancan"

# 三方平台 OAuth 验证登陆
gem "omniauth"
gem "omniauth-github"
gem "omniauth-wechat-oauth2"

# 使用JWT实现Token认证
gem 'jwt'
# 符合 JWT (JSON Web Token) 规范的认证 API
gem 'knock'

# grape 可以帮助我们快速的构建和 Rails 完美融合的 API 接口。
gem 'grape'
gem 'grape-entity'
gem 'grape-swagger'
gem 'grape-swagger-entity'
gem 'grape-swagger-rails'
gem 'grape_logging'
gem 'grape_on_rails_routes'

# GraphQL一种用于 API 的查询语言
gem 'graphql', '~> 1.9'

# 邮件服务
# gem "postmark"
# gem "postmark-rails"

# 拒绝低版本浏览器的访问，并给其返回一个让其升级的页面。
gem 'browser_warrior', '>= 0.8.0'

# 异常监控通知
# gem 'exception_notification'
# 在后台管理页面显示异常信息
# gem 'exception-track'
# gem 'slack-notifier'

# RPC远程过程调用
# gem 'grpc'

# 用于处理跨域资源共享（CORS）的机架中间件，这使得跨域AJAX成为可能。
# gem 'rack-cors'

# 赞、关注、收藏、屏蔽等功能的数据结构
# gem "action-store"

# 后台管理
# gem 'activeadmin'
# 后台管理的前端UI
# gem 'arctic_admin'

# 管理配置信息的库。
# gem "rails-settings-cached", "~> 2.0"

# 一个使用 Ruby 连接和操作 RabbitMQ 的客户端
gem "bunny", "~> 2.14.1"
# 业务通过 Bunny 在 Rails 中简易、快速地生产发布了消息，就需要有消费者来接收和消费消息，
# Sneakers 是一个处理 RabbitMQ 消息队列的高性能 Ruby 框架
gem 'sneakers'

# aasm ruby类的状态机（支持普通Ruby，ActiveRecord，Mongoid）
gem 'aasm'

# 一些使用rack协议编写的小工具。
gem "rack-contrib"

# 保护你的应用免收不良客户端的请求的拦截器。
gem "rack-attack"

# bugsnageRuby的Bugsnag异常报告器会立即通知您从Rails，Sinatra，Rack或纯Ruby应用程序引发的异常。
# 任何未捕获的异常都会触发通知，该通知将发送到您的Bugsnag项目。
gem "bugsnag", "~> 6.12"
gem "uniform_notifier"

# URL 友好的 ID，可以把一些不想暴露的url地址中的信息给使用id替代掉。
gem 'friendly_id'

# 所见即所得编辑器
gem 'ckeditor'

# 改变 rails 默认的日志，使变得更好。更简洁且高效的显示日志内容。
gem "lograge"
# Logstash与Beats，Elasticsearch和Kibana一起是Elastic Stack的一部分。
# Logstash是服务器端数据处理管道，它同时从多个源中提取数据，进行转换，然后将其发送到您喜欢的“stash”。
gem 'logstash-event'

# 状态机
gem  'aasm'
group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]

  # 开发环境中发邮件的时候不用发到真实的邮箱中了
  gem 'letter_opener'

  gem 'factory_bot_rails'

  # BDD 行为驱动开发
  # gem 'cucumber'
  # gem 'cucumber-rails', require: false
  # gem 'cucumber-api-steps', require: false

  # faker生成伪数据。
  # gem 'faker'

  # 一个提供“时间旅行”和“时间冻结”功能的gem，使测试依赖于时间的代码变得非常简单。它提供了
  # 一个统一的方法，可以在单个调用中模拟Time.now，Date.today和DateTime.now。
  # gem 'timecop'

  # 生成文档工具
  gem 'sdoc'
end

group :development do
  # web-console是RubyonRails应用程序在浏览器上的调试工具,报错的时候可以调试的。
  gem 'web-console', '>= 3.3.0'

  # 监听文件变动，并你去通知修改
  gem 'listen', '>= 3.0.5', '< 3.2'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  # 运行测试时，保持development在后台运行，不需要重启
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'

  # capistrano相关的gem。如果服务器没有安装rvm及ruby可以使用rvm1-capistrano3这个gem去在服务端自动安装。
  gem 'capistrano', '~> 3.11', require: false
  gem 'capistrano-bundler', '~> 1.5', require: false
  gem 'capistrano-rails', '~> 1.4', require: false
  gem 'capistrano-rvm', require: false
  # 可以在服务器安装rvm及ruby的工具。
  gem 'rvm1-capistrano3', require: false
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
  gem 'rubocop', '~> 0.81.0', require: false
  gem 'rubocop-rspec', require: false
  gem 'rubocop-performance'
  gem 'rubocop-rails', require: false

  # 检测你的gem使用情况。命令：  bundle exec derailed bundle:mem   使用derailed -h查看可用命令
  gem 'derailed'
  gem 'stackprof'
  gem 'derailed_benchmarks'

  # 一个文档生成工具
  gem 'yard', '>= 0.9.20'

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

  # 在Rails应用程序中安装GraphiQL查询编辑器
  # gem 'graphiql-rails', '~> 1.7.0'

  # 在日志中写入请求源信息
  gem 'active_record_query_trace'

  # 给你的MacOS的发送通知消息
  # gem 'terminal-notifier'
end

group :test do
  # 基于机架的Web应用程序的集成测试工具。它模拟用户如何与网站交互
  gem 'capybara', '>= 2.15'
  # 模拟用户的行为，与html交互
  gem "selenium-webdriver"

  # 可以更轻松地运行Selenium(浏览器自动测试框架)测试。
  gem 'webdrivers'

  # 清理数据库的策略。可用于确保测试的清洁状态。
  gem 'database_cleaner'

  gem 'launchy'

  # 配置测试需要的数据
  gem 'webmock'

  # 单元测试
  gem 'rspec'
  gem 'rspec-core'
  gem 'rspec-expectations'
  gem 'rspec-mocks'
  gem 'rspec-rails'
  gem 'rspec-support'
  gem 'rspec-sidekiq'

  # 生成虚假数据
  gem "faker"

  # 代码覆盖率工具。产生精美的报告。
  gem 'simplecov', require: false
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
