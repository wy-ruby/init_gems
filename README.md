init_gems
---------------
　　init_gems是为了节省开发者的安装配置各个常用的gem的时间，并对这些gem进行了一些简单的说明介绍。可以让开发者直接上手使用，并且让你知道
它大概是干什么的，并且我这里对其的基本配置已经够用了，想了解或者使用更多的时候可以再细读其文档。    

### 目前已经配置好了的gem：
1. 发布部署套件：capistrano、capistrano-bundler、capistrano-rails、capistrano-rvm、rvm1-capistrano3、capistrano-sidekiq、capistrano3-puma
2. redis相关：hiredis、redis、redis-namespace、redis-rails、redis-rack-cache
3. 队列：sidekiq
4. 定时任务：whenever
5. 前端页面性能增加：turbolinks
6. 更加方便的种子数据编写：seed-fu
7. 环境变量配置：figaro
8. 后续不断的更新……

### 注意事项：
1. gem的配置说明文档一般都是放在配置页面，如config/deploy.rb中写的是capistrano及其套件中的说明文档，还一些是在docs文件夹下。　
2. 在项目中也有不少只是为了测试或者需要写文档需要而添加的一些文件，如worker/sidekiq_test_worker.rb。    
3. 这里对涉及敏感的配置文件添加到忽略上了，不过都有对应的xxx.example.xx表示。    


### 使用：
　　这里没有对其进行高大上的脚本一键安装的封装，所以需要去克隆下来使用。
```
  git clone git@github.com:wy-ruby/init_gems.git
```
　　可以看到里面有不同的分支，不同的分支代表了不同的gem的配置及使用。
