namespace :first_deploy do
  desc "判断是否存在部署目录，如果不存在的话就默认是第一次部署，就执行数据库创建，初始化文件夹，上传配置文件操作。"
  task :init do
    on roles(:all) do
      invoke "deploy:check:directories"
      invoke "deploy:check:linked_dirs"
      invoke "deploy:check:make_linked_dirs"
      invoke "first_deploy:upload_linked_files"
      invoke "deploy:check:linked_files"
      # invoke "first_deploy:create_database"
    end
  end

  # 给服务器上，上传必要的配置文件。
  task :upload_linked_files do
    on roles(:all) do
      fetch(:linked_files).each do |filename|
        upload! filename, File.expand_path("config", shared_path)
      end
    end
  end

end
