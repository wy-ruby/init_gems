# frozen_string_literal: true

# config valid for current version and patch releases of Capistrano
lock '~> 3.11.0'

# 在部署期间，列出的文件夹将从应用程序的共享文件夹中链接到每个发布目录。
# .bundle 文件也是会被设置在shared文件夹下的，该目录中有一个配置文件，配置所有的gem包的存放位置的，存放目录一般是shared/bundle/ruby/2.3.0/gems
append :linked_dirs, 'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', '.bundle', 'public/system', 'public/uploads'
# 在部署期间，列出的文件将从应用程序的共享文件夹中链接到每个发布目录。可用于持久性配置文件，如database.yml等文件ls。
# 注意这里rails是5.2版本的，从这个版本开始，config/secrets.yml变成了config/master.key，即低于5.2版本的话要引入的是secrets.yml,否则会报错。注意这些手动添加的配置中需要有对应的内容，否则也会报错
append :linked_files, 'config/database.yml', 'config/config.yml', 'config/redis.yml', 'config/master.key'

# 服务器上的ruby版本以及gemset名
@rvm_version = '2.5.1@init_gems'

# 项目仓库配置
@project_name = 'init_gems'
@git_url = 'git@github.com:wy-ruby'
@repo_url = "#{@git_url}/#{@project_name}.git"

# 服务器上部署的路径配置
@app_dir = 'rails_gems_tool'
@complete_app_dir = "/home/live/#{@app_dir}"

# 输入要发布的分支
# ask(:use_branch, 'master', echo: true)
# @branch = fetch(:use_branch)
@branch = 'dev_and_test_gems'

# 进行参数设置
set :deploy_to, @complete_app_dir  # 部署的服务器的路径。默认是 { "/var/www/#{fetch(:application)}" }
set :application, @app_dir         # 部署到的服务器的项目名
# set :scm, :git                   # 配置源码管理工具,在Capfile中引入即可，这里不建议引入否则会提醒。目前支持 :git 、:hg 、 :svn，默认是：git
set :repo_url, @repo_url           # 部署的仓库的地址配置
set :branch, @branch               # 仓库的分支，默认是master
set :pty, false                    # 是否使用SSHKit 详见 https://github.com/capistrano/sshkit/
set :log_level, :debug             # 使用SSHKit的时候，选择的日志的层级。有:info, :warn，:error, :debug
set :format, :airbrussh            # 还有其他的变量 :dot和 :pretty,使用airbrussh的时候打印的是:warn or :error，使用:dot或者:pretty打印配置的。
set :keep_releases, 5              # 保持最近多少次的部署，在服务器上是release文件夹中存在多少个对应的源码的文件夹。
set :shared_directory, 'shared'    # 设置部署的服务器端的共享文件夹目录名。默认: shared
set :releases_directory, 'releases'# 设置部署的服务器端的发布的文件夹目录名。默认: releases
set :current_directory, 'current'  # 设置指向当前最新成功部署发布文件夹的当前链接的名称。默认: current

# 设置release的目录格式
set :release_name, Time.now.strftime('%Y%m%d%H%M%S')

# 格式化部署的时候显示的工具,设置其颜色以及保存的日志目录和字符宽度。在3.5以上的版本中 默认的
set :format_options, color: false, truncate: 80, log_file: 'log/capistrano.log', command_output: true

# 配置rvm的ruby版本以及gemset
set :rvm_ruby_version, @rvm_version

# 如果db/migrate文件没有改变就跳过
set :conditionally_migrate, true

# 配置assets的目录，压缩编译静态文件在该配置下的目录进行。
set :assets_manifests, ['app/assets/config/manifest.js']

# 配置assets:precompile task中的RAILS_GROUPS的环境变量的值。
# set :rails_assets_groups, :assets

# 虽然迁移一般是针对数据库的，但是在rails中数据库的迁移和rails框架密切相关，因此这里设置为应用 :app，而不是 :db
set :migration_role, :app

# 创建文件夹public/images, public/javascripts, 以及 public/stylesheets在每个部署的服务器上
set :normalize_asset_timestamps, %w[public/images public/javascripts public/stylesheets]

# 设置编译的静态资源角色
set :assets_roles, %i[web app]

# bundle相关。本身deploy.rake有做在updating的时候设置set_release_path的，然后就可以设置对应的release_path了，但是不知道为什么没有设置
# 所以这里需要在第一次发布的时候设置下，之后必须要删除了，并设置set :bundle_gemfile, -> { current_path.join('Gemfile') }即可
set_release_path
set :bundle_gemfile, -> { release_path.join('Gemfile') }

# capistrano3版本及以上引入whenever的时候带上该命令是可以执行whenever -i的，即更新crontab的配置。
set :whenever_identifier, -> { "#{fetch(:application)}_#{fetch(:stage)}" }
set :default_env, BUNDLE_GEMFILE: "#{release_path}/Gemfile"
set :whenever_load_file, -> { File.join(release_path, 'config', 'schedule.rb') }

# 配置unicorn的运行的目录
set :unicorn_config_path, -> { File.join(release_path, 'config', 'unicorn.rb') }
# 必须要设置该参数，否则无法执行。
set :unicorn_roles, %i[db app web]
# 这个参数必须要配置，要不然会默认执行development环境的。
set :unicorn_rack_env, -> { fetch(:stage) }

# 配置sidekiq,这里不需要去设置sidekiq的启动或者重启，在capistrano_sidekiq中已经自动执行了。
set :sidekiq_config, "#{release_path}/config/sidekiq.yml"
# 这个参数必须要设置，否则无法执行。
set :sidekiq_roles, %i[db app web]

# 执行deploy中进行的操作
# 在第一次部署的时候运行该命令,用来创建数据库。
# before 'deploy:updated', 'deploy:curd_database'
# 使用unicorn去运行该命令，如果是首次运行或者服务器端的unicorn进程挂掉的情况的话使用unicorn:start，其他的情况使用unicorn:restart或者unicorn:legacy_restart
after 'deploy:publishing', 'deploy:restart'
# 执行db/fixtures/*下的任务
before 'deploy:publishing', 'db:seed_fu'
# 等发布完成之后把那些没有用到的gem给删除了,这个建议等删除的gem比较多的话再用。
# after 'deploy:published', 'bundler:clean'

# before 'deploy:starting', 'deploy:upload_linked_files'

namespace :deploy do
  # 自定义了一个部署任务, 即自动运行 rake RAILS_ENV=rails_env db:create
  # 其中 release_path 指的是当前 release 目录
  # `fetch(:rails_env)` 读取配置中的 rails_env 变量, 并在 rake 命令中带上 env 变量
  task :curd_database do
    on roles(:db) do
      within release_path do
        with rails_env: fetch(:rails_env) do
          # execute :rake, 'db:create' #如果是第一次部署可以加上该行代码以便创建数据库。
          # 根据设置的：rails_evn的变量配置对应的RAILS_ENV环境，然后进行rake下的migrate操作
          execute :rake, 'db:create'
        end
      end
    end
  end

  # 重启unicorn服务
  task :restart do
    invoke 'unicorn:legacy_restart'
  end

  # 给服务器上，上传必要的文件
  task :upload_linked_files do
    on roles(:app) do
      upload! "#{shared_path}/config/", "/config/database.yml"
      upload! "/config/master.key", "#{shared_path}/config/master.key"
      upload! "/config/redis.yml", "#{shared_path}/config/redis.yml"
    end
  end

end
