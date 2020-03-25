###Devise：
> 是一种灵活的基于管理员的Rails认证解决方案。  

**主要功能：**
1. 数据库的验证：在数据库中散列并存储密码，以便在登录时验证用户的真实性。  
   身份验证可以通过POST请求或HTTP基本身份验证来完成。
2. Omniauth的支持：添加OmniAuth（https://github.com/OmniAuth/OmniAuth）支持。
3. 邮件确认：发送带有确认指令的电子邮件，并在登录时验证帐户是否已确认。
4. 密码的重置：重置用户密码并发送重置指令。
5. 注册和销户：通过注册过程处理注册用户，也允许他们编辑和销毁他们的帐户。
6. 记住用户：管理生成和清除令牌，以便从保存的cookie中记住用户。
7. 用户的跟踪：跟踪登录计数、时间戳和IP地址。
8. 超时退出登录：使在指定时间段内未处于活动状态的会话过期。
9. 安全验证：提供电子邮件和密码的验证。它是可选的，可以自定义，因此您可以定义自己的验证。
10. 账户锁定：在指定次数的登录尝试失败后锁定帐户。可以通过电子邮件或在指定时间段后解锁。 
 
####1. 开始使用Devise: 

Devise 4.0需要您的rails版本在rails4.1以上。首先添加devise在gemfile中,并运行bundle install。
```ruby
gem 'devise'
```
可以使用rails g -h查看rails g下的devise相关的命令，这里运行
```ruby
rails g devise:install # => 该命令用来初始化安装devise的相关文件
```
执行后会创建两个文件，并提示你在不同的环境中配置相关的配置项、路由以及设置视图文件的配置。
```shell script
create  config/initializers/devise.rb
create  config/locales/devise.en.yml
```
创建或者更新用户、管理员等的model，例如：
```shell script
# 该命令会创建或者更新User的模型，添加路由，创建迁移文件。
# 之后可以根据需要去修改迁移文件中的字段信息，然后执行迁移。
rails g devise User
```
> 注意:更新devise的配置后需要重启应用，否则可能会出现无法登陆的情况。

###2. 

