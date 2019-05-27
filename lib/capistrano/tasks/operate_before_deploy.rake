namespace :first_deploy do
  desc "判断是否存在部署目录，如果不存在的话就默认是第一次部署，就执行数据库创建，初始化文件夹，上传配置文件操作。"
  task :init do
    on roles(:all) do
      if test("[ ! -d #{fetch(:deploy_to)} ]")
        # 第一次配置需要安装bundler
        invoke "first_deploy:install_bundle"
        invoke "deploy:check:directories"
        invoke "deploy:check:linked_dirs"
        invoke "deploy:check:make_linked_dirs"
        # 上传git中忽略的但是必要的配置文件到要部署的服务器
        invoke "first_deploy:upload_linked_files"
        invoke "deploy:check:linked_files"
      end
    end
  end

  # 给服务器上，上传必要的配置文件。
  task :upload_linked_files do
    on roles(:all) do
      fetch(:linked_files).each do |filename|
        upload! filename, File.expand_path("config", shared_path)
      end
      # 上传puma的配置文件到要部署的服务器
      invoke "puma:config"
      # 上传nginx的配置文件到要部署的服务器
      invoke "puma:nginx_config"
    end
  end

  # 在服务器上配置需要的gemset以及安装bundle。默认是在服务器上已经安装好了rvm和 +对应版本+ 的ruby了。
  # 如果没有安装rvm以及对应版本的ruby的建议先安装，后续这块会有更新。
  task :install_bundle do
    on roles(:all) do
      gems = capture(:rvm, "#{fetch(:rvm1_ruby_version)} do gem list")
      # 判断bundler是否存在。
      bundler_arr = gems.tr("\\\n\\\r", "-").split("--").select { |v| v =~ /^bundler .*/ }
      if bundler_arr.empty?
        # 目前最新版的bundler2.0.3有点问题，官方推荐用这个版本的。
        execute(:rvm, "#{fetch(:rvm1_ruby_version)} do gem install bundler -v '1.17.3'")
      else
        puts "服务器上已经安装了#{bundler_arr[0]}了"
      end
    end
  end

end
