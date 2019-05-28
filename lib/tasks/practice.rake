namespace :practice do
  desc "测试whenever的执行情况"
  task whenever_test: :environment do
    p "hello world!"
  end

end
