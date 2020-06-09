###Devise：

> 是一种灵活的基于管理员的Rails认证解决方案。  

**主要功能：**

1. 数据库的验证：加密并在数据库中存储密码，以在登录时验证用户的真实性。可以通过POST请求   或HTTP基本身份验证来完成身份验证。
2. Omniauth的支持：添加[OmniAuth](https://github.com/OmniAuth/OmniAuth)支持。
3. 邮件确认：发送带有确认指令的电子邮件，并在登录时验证帐户是否已确认。
4. 密码的重置：重置用户密码并发送重置指令。
5. 注册和销户：通过注册过程处理注册用户，也允许他们编辑和销毁他们的帐户。
6. 记住用户：管理生成和清除令牌，以便从保存的cookie中记住用户。
7. 用户的跟踪：跟踪登录计数、时间戳和IP地址。
8. 超时退出登录：使在指定时间段内未处于活动状态的会话过期。
9. 安全验证：提供电子邮件和密码的验证。它是可选的，可以自定义，因此您可以定义自己的验证。
10. 账户锁定：在指定次数的登录尝试失败后锁定帐户。可以通过电子邮件或在指定时间段后解锁。 

####1. 初始化Devise: 

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

您需要在每种环境中为Devise邮件程序设置默认的URL选项

```shell
# 例如在开发环境中的配置 config/environments/development.rb
config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }
```

创建或者更新用户、管理员等的model，例如：

```shell script
# 该命令会创建或者更新User的模型，添加路由，创建迁移文件。
# 之后可以根据需要去修改迁移文件中的字段信息，然后执行迁移。
rails g devise User
```

> 注意:更新devise的配置后需要重启应用，否则可能会出现无法登陆的情况。



###2. 应用中使用Devise

####2.1、在view中的配置

> 如果你是有user和admin用户的话，一般会在这两个controller对应的view中去创建相应的devise文件，如果没有创建的话会默认从`devise/sessions`中读取。

所以这里最好要执行两个命令

```ruby
# 用于生成公共的view文件。
rails generate devise:views

# 用于生成user视图的专用的文件。
rails generate devise:views users

# 还可以自定义生成的devise的view文件
rails generate devise:views -v registrations confirmations
```

#### 2.2、在controller中的配置

1. 使用生成器创建自定义控制器

```ruby
# 其实这里可以不创建自定义的控制器，直接使用默认的即可。
rails generate devise:controllers [scope]
```

如果您将`users`指定为范围即执行命令:`rails generate devise:controllers users`，则将会在`app/controllers/users/`中创建对应的控制器，这样可以修改默认路由的一些信息。

```ruby
# 将会在app/controllers/users/目录下创建以下的控制器
create  app/controllers/users/confirmations_controller.rb
create  app/controllers/users/passwords_controller.rb
create  app/controllers/users/registrations_controller.rb
create  app/controllers/users/sessions_controller.rb
create  app/controllers/users/unlocks_controller.rb
create  app/controllers/users/omniauth_callbacks_controller.rb
```

2. 告诉路由器使用此控制器

   ```ruby
   devise_for :users, controllers: { sessions: "users/sessions" }
   ```

3. 从`devise/sessions`到`users/sessions`选择视图。由于控制器已更改，因此它将不使用位于`devise/sessions`中的默认视图



#### 2.3、路由配置

#####2.3.1、Devise有自己的一套DSL来实现相应的路由。

```ruby
# 例如配置该路由的时候。
devise_for :users
```

用户验证会话的session路由，该路由是默认(就是在模型中不添加devise的模块也会有的路由)的路由：

|         功能         | method |     请求url     |   controller    | action  |
| :------------------: | :----: | :-------------: | :-------------: | ------- |
|   new_user_session   |  GET   | /users/sign_in  | devise/sessions | new     |
|     user_session     |  POST  | /users/sign_in  | devise/sessions | create  |
| destroy_user_session | DELETE | /users/sign_out | devise/sessions | destroy |

如果model中有`:recoverable`配置，可以使用以下路由：

|        功能        | 请求方式 |            请求url             |      控制器      |  动作  |
| :----------------: | :------: | :----------------------------: | :--------------: | :----: |
| new_user_password  |   GET    | /users/password/new(.:format)  | devise/passwords |  new   |
| edit_user_password |   GET    | /users/password/edit(.:format) | devise/passwords |  edit  |
|   user_password    |   PUT    |   /users/password(.:format)    | devise/passwords | update |
|   user_password    |   POST   |   /users/password(.:format)    | devise/passwords | create |

如果model中有`:confirmable`配置，可以使用以下路由：

|         功能          | Method |              请求url              |        控制器        |  动作  |
| :-------------------: | :----: | :-------------------------------: | :------------------: | :----: |
| new_user_confirmation |  GET   | /users/confirmation/new(.:format) | devise/confirmations |  new   |
|   user_confirmation   |  GET   |   /users/confirmation(.:format)   | devise/confirmations |  show  |
|   user_confirmation   |  POST  |   /users/confirmation(.:format)   | devise/confirmations | create |

如果model中有`:registerable`配置，可以使用以下路由：

| 功能                   | Method | 请求url                  | 控制器               | 动作   |
| ---------------------- | ------ | ------------------------ | -------------------- | ------ |
| 注销用户               | GET    | /users/cancel(.:format)  | devise/registrations | cancel |
| new_user_registration  | GET    | /users/sign_up(.:format) | devise/registrations | new    |
| edit_user_registration | GET    | /users/edit(.:format)    | devise/registrations | edit   |
| user_registration      | PATCH  | /users(.:format)         | devise/registrations | update |
| user_registration      | PUT    | /users(.:format)         | devise/registrations | update |
| user_registration      | DELETE | /users(.:format)         | devise/registrations | delete |
| user_registration      | POST   | /users(.:format)         | devise/registrations | create |

#####2.3.2、Devise中的路由的方法集成

在Devise的路由中`devise_for`可以很好的和其他路由方法集成，例如和`namespace`

```ruby
# 此时路由将使用 publisher/sessions 控制器 ，而不是 devise/sessions 控制器。
# 请求url变成了 /publisher/account/sign_in
namespace :publisher do
  devise_for :account
end

# 并且要注意的是日添加rails中的路由方法的时候对应的帮助方法的名字也是会被改变的。例如：
# 查看如果使用devise_for :users的时候和现在的对比
current_users current_publisher_account
authenticate_users! authenticate_publisher_account!
user_signed_in   publisher_account_signed_in
user_session   publisher_account_session
```

`devise_for`方法的`options`

```ruby
# 1. 使用path去更改请求url，此时这里把上述中的所有路由的请求的url从users变成accounts。
# 注意此时需要有users控制器，以及user模型
# 此时登录路由从 /users/sign_in 变成 /accounts/he/sign_in
devise_for :users, path: 'accounts/he'

# 2. 使用controller选项更改默认控制器。
devise_for :users, controllers: { sessions: "users/sessions" }

# 3. 使用singular改变帮助方法的名称，("authenticate_#{singular}!", "#{singular}_signed_in?", "current_#{singular}", "#{singular}_session") 方法名变成这样了
devise_for :admins, singular: :manager

# 4. 配置不同的路径名来覆盖默认值:sign_in，:sign_out，:sign_up，:password，:confirm，:unlock
devise_for :users, path_names: {
  sign_in: 'login', sign_out: 'logout',
  password: 'secret', confirmation: 'verification',
  registration: 'register', edit: 'edit/profile'
}

# 5. 查找控制器的名称空间，默认是使用"devise"，例如devise_for :users的时候，默认是使用devise/sessions, devise/registrations的控制器，这里可以通过module选项修改成users。此时就是使用users/sessions, users/registrations作为默认控制器了。
devise_for :users, module: "users"
# 这个和添加module选项会得到同样的结果
namespace :users do
  devise_for :users, path: "/"
end

# 6. sign_out 默认是使用:delete action如果您希望将其限制为仅接受：post或：delete请求，则应这样做
devise_for :users, sign_out_via: [:post, :delete]

# 7. 跳过及仅仅使用模块
devise_for :users, skip: :sessions
devise_for :users, only: :sessions

# 8. 在请求url中一般会添加 (.:format) 默认是true添加，可以设置为false
devise_for :users, format: false

# 9. 可以在外层嵌套scope，再调用devise_for。 这样可以在请求的url的外层嵌套一个/my
# 例如 可以生成请求url为 /my/users/sign_in 响应的控制器为 devise/sessions
scope "/my" do
  devise_for :users
end

# 10. 可以使用 constraints 关键词进行片段约束，和rails routes中的一样。
# 11. 可以使用 defaults 关键词设定的散列为路由定义默认值。
```



####2.4、其他配置

​		Devise将创建一些帮助程序，以在您的控制器和视图中使用，例如某个控制器需要验证用户，则是在  

你的控制器前面添加一个`before_action`方法。  

　　注意在rails5之后`protect_from_forgery`这个方法不再是位于`before_action`链之前了，所以需要调整好  

位置`authenticate_user`是在`protect_from_forgery`之后，或者使用`protect_from_forgery prepend: true` 

```ruby
# 这里假定您的设计的模型是User，如果你使用的是其他模型需要把 _user 替换成对应的模型 _yourmodel 

# 控制器需要验证用户的用法，如果把这个方法添加到application_controller.rb的话，就是任何请求前都要先验证用户是否登录。
before_action :authenticate_user!

# 要验证用户是否登录
user_signed_in?

# 获取当前用户
current_user

# 获取用户的session
user_session
```

　　 登录用户，确认帐户或更新密码后，Devise将查找要重定向到的作用域范围的根路径。例如，使用`user`资源时，将使用`user_root_path`（如果存在）否则，将使用默认的`root_path`。您还可以自定义以下两个方法 `after_sign_in_path_for`和`after_sign_out_path_for`以覆盖devise默认的配置。



###3. Devise的配置详解

####3.1、初始配置

1. devise的所有初始化配置项都是在`config/initializers/devise.rb`中。

   ```ruby
   Devise.setup do |config|
     # 针对各个模块的配置项的配置都在该文件中，根据文件中的注释提示内容进行修改配置即可。
     # Controller configuration
     config.parent_controller = 'DeviseController'
     ...
     # Mailer Configuration
     config.parent_mailer = 'ActionMailer::Base'
     ...
   end
   ```

2. 配置项中的模块都需要引入到要使用的`model`中。

   ```ruby
   class User < ApplicationRecord
   	has_secure_password
     # 下面是Devise默认的模块都可以按需引入:
     # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
     devise :database_authenticatable, :registerable, :timeoutable,
            :confirmable, :trackable,:recoverable, :rememberable
   end
   ```

3. 配置`db/migrate`下的迁移文件。

   ```ruby
   class AddDeviseToUsers < ActiveRecord::Migration[5.2]
     def self.up
       change_table :users do |t|
         ## Database authenticatable
         # t.string :email,              null: false, default: ""
         t.string :encrypted_password, null: false, default: ""
   
         ## Recoverable
         t.string   :reset_password_token
         t.datetime :reset_password_sent_at
   
         ## Rememberable
         t.datetime :remember_created_at
   
         ## Trackable
         t.integer  :sign_in_count, default: 0, null: false
         t.datetime :current_sign_in_at
         t.datetime :last_sign_in_at
         t.string   :current_sign_in_ip
         t.string   :last_sign_in_ip
   
         ## Confirmable
         t.string   :confirmation_token
         t.datetime :confirmed_at
         t.datetime :confirmation_sent_at
         t.string   :unconfirmed_email # Only if using reconfirmable
   
         ## Lockable
         t.integer  :failed_attempts, default: 0, null: false # Only if lock strategy is :failed_attempts
         t.string   :unlock_token  # Only if unlock strategy is :email or :both
         t.datetime :locked_at
         
         # 如果原始模型中没有包含时间戳，请在下面取消注释
         # t.timestamps null: false
       end
   
       add_index :users, :email,                unique: true
       add_index :users, :reset_password_token, unique: true
       add_index :users, :confirmation_token,   unique: true
       add_index :users, :unlock_token,         unique: true
     end
   
     def self.down
       raise ActiveRecord::IrreversibleMigration
     end
   end
   ```

4. 路由配置

   ```ruby
   
   ```


#### 3.2、添加一个自定义的Devise模块





###4. 添加omniAuth的支持

> 在`Devise`中添加`OmniAuth`插件支持的时候，不需要在`OmniAuth`的`config/initializers/omniauth.rb`初始化配置文件中添加插件配置。

首先第一步是添加对应的`OmniAuth gem`到你的Gemfile中并使用`bundle install`安装。然后需要去添加到用户模型中。

```ruby
rails g migration AddOmniauthToUsers provider:string uid:string
rake db:migrate
```

####4.1、默认直接在devise中配置一个omniauth供应商。

然后就是需要在devise的初始化配置文件`config/initializers/devise.rb`中配置该`OmniAuth gem`。

```ruby
# 这里如果是有多种授权登录方式的话，可以直接在这个地方配置。  
config.omniauth :github, 'APP_ID', 'APP_SECRET', scope: 'user,public_repo'
```

 再之后是要在你的`User`模型中配置你的策略，添加上该 `OmniAuth gem`

```ruby
# 这个里面的github的作用是为了让devise生成登录路由，可以添加多个OmniAuth gem
devise :omniauthable, omniauth_providers: %i[github]

# 此时使用命令rake routes查看路由，可以发现下面这一个验证一个回调路由。
user_github_omniauth_authorize GET|POST /users/auth/github(.:format)                                                            
users/omniauth_callbacks#passthru 

user_github_omniauth_callback GET|POST /users/auth/github/callback(.:format)
users/omniauth_callbacks#github
```

所以此时应该在你的`users/omniauth_callbacks_controller.rb`中去添加一个`github`的动作。

```ruby
class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def github
    # 一般处理授权后得到的用户信息是需要在模型中处理的，所以这个from_omniauth方法是在user模型中实现。
    @user = User.from_omniauth(request.env["omniauth.auth"])
		
    # 判断该用户是否已经持久化。
    if @user.persisted?
      # 这个sign_in_and_redirect方法是devise实现的，作用是登录用户并尝试首先重定向到存储位置，然后重定向到after_sign_in_path_for指定的url。它接受与sign_in方法相同的参数。
      sign_in_and_redirect @user, event: :authentication
      # 这个set_flash_message方法是devise实现的，是为了闪存消息。
      set_flash_message(:notice, :success, kind: "Github") if is_navigational_format?
    else
      session["devise.github_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end

  def failure
    redirect_to root_path
  end
end

# 或者可以放到一个方法中，然后再起不同的别名。如下：
class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def create
    
  end

  def failure
    redirect_to root_path
  end
  alias_method :wechat, :all
  alias_method :github, :all
end

```

注意：`request.env["omniauth.auth"]`这个变量是获取授权后的该用户的各种信息。一般处理该信息的时候是在模型中处理，所以此时应该在`user`这个模型中去添加`from_omniauth`类方法。

```ruby
def self.from_omniauth(auth)
  where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
    user.email = auth.info.email
    user.password = Devise.friendly_token[0, 20]
    user.name = auth.info.name   # assuming the user model has a name
    user.image = auth.info.image # assuming the user model has an image
    # If you are using confirmable and the provider(s) you use validate emails, 
    # uncomment the line below to skip the confirmation emails.
    # user.skip_confirmation!
  end
end
```



####4.2、devise中配置多个omniauth供应商（经测试这个相对比较麻烦）

首先，移除在`User`模型中的`OmniAuth`的配置，即把devise后面的`:omniauthable, omniauth_providers: %w[github]`都给移除。

```ruby
class User < ApplicationRecord
  devise  :omniauthable, omniauth_providers: %w[github]
end
```

在`devise`的配置文件`config/initializers/devise.rb`中去注释掉下方的配置，因为这个地方的配置只适合一个`OmniAuth`的提供者的情况，例如你的应用只允许使用`github`授权登录的情况。如果你想要使用微信和QQ登录，就需要引入多个`OmniAuth`供应者了，此时的直接在`devise`的配置文件中配置的就不适用了。

```ruby
 config.omniauth :github, ENV['GITHUB_KEY'], ENV['GITHUB_SECRET']
```

注释掉上面的代码之后，在`OmniAuth`的初始化文件中去添加供应者。例如：

```ruby
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :wechat, ENV["WECHAT_APP_ID"], ENV["WECHAT_APP_SECRET"]
  provider :github, ENV['GITHUB_KEY'], ENV['GITHUB_SECRET']
end
```

然后去创建`OmniAuth`的控制器及路由

```ruby
rails g controller Authentications

# 创建路由
# 如果是 Rails 3 或者 Rails 4
get "/auth/:action/callback", :to => "authentications", :constraints => { :action => /twitter|google/ }

# 如果是Rails 5
get "/auth/:action/callback", :controller => "authentications", :constraints => { :action => /twitter|google/ }
# 也可以将所有OmniAuth身份验证都定向到相同的create操作，而与使用的提供程序无关
get "/auth/:provider/callback" => "authentications#create"

# 如果是Rails 6
get "/auth/twitter/callback" => "authentications#twitter"
get "/auth/google/callback"  => "authentications#google"
```

可以创建一个`on_failure`钩子，去处理在`Authentications`控制器中找不到路由的时候响应的`AuthenticationsController`,中的`failure`方法。

```ruby
Rails.application.config.middleware.use OmniAuth::Builder do
  on_failure { |env| AuthenticationsController.action(:failure).call(env) }
end
```

或者可以这样处理在`Authentications`控制器中找不到路由的响应方法。

```ruby
OmniAuth.config.on_failure = Proc.new { |env| AuthenticationsController.action(:failure).call(env) }
```





