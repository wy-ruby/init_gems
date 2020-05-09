# frozen_string_literal: true

# Use this hook to configure devise mailer, warden hooks and so forth.
# Many of these configuration options can be set straight in your model.
Devise.setup do |config|
  # 配置Devise的密钥，更改此密钥将使数据库中所有现有的确认、重置密码和解锁令牌无效。默认是使用的是secret_key_base中的密钥。
  # The secret key used by Devise. Devise uses this key to generate
  # random tokens. Changing this key will render invalid all existing
  # confirmation, reset password and unlock tokens in the database.
  # Devise will use the `secret_key_base` as its `secret_key`
  # by default. You can change it below and use your own secret key.
  # config.secret_key = '0cec8f92fc9089fa26ee40a7e363d2fe75a22ed14a139b4c007c58f40425117605f67486eee27f720f34f5aeaae2d19cb62189e5c273f2598d39795503105f0b'

  # ==> Controller configuration
  # 控制器配置，设置父级控制器的名字。
  # Configure the parent class to the devise controllers.
  # config.parent_controller = 'DeviseController'

  # ==> Mailer Configuration
  # 邮件配置，该项是配置邮件的默认发件人，如果你使用自己的邮件类的话，该选项将会被覆盖。
  # Configure the e-mail address which will be shown in Devise::Mailer,
  # note that it will be overwritten if you use your own mailer class
  # with default "from" parameter.
  config.mailer_sender = Rails.application.credentials[:email_user]

  # 配置负责发送电子邮件的类，默认使用Devise::Mailer
  # Configure the class responsible to send e-mails.
  # config.mailer = 'Devise::Mailer'

  # 配置负责发送电子邮件的父类
  # Configure the parent class responsible to send e-mails.
  config.parent_mailer = 'ActionMailer::Base'

  # ==> ORM configuration
  # Devise支持两种ORM库，active_record和mongoid，默认是active_record
  # Load and configure the ORM. Supports :active_record (default) and
  # :mongoid (bson_ext recommended) by default. Other ORMs may be
  # available as additional gems.
  require 'devise/orm/active_record'

  # ==> Configuration for any authentication mechanism
  # Configure which keys are used when authenticating a user. The default is
  # just :email. You can configure it to use [:username, :subdomain], so for
  # authenticating a user, both parameters are required. Remember that those
  # parameters are used only when authenticating and not when retrieving from
  # session. If you need permissions, you should implement that in a before filter.
  # You can also supply a hash where the value is a boolean determining whether
  # or not authentication should be aborted when the value is not present.
  # config.authentication_keys = [:email]

  # Configure parameters from the request object used for authentication. Each entry
  # given should be a request method and it will automatically be passed to the
  # find_for_authentication method and considered in your model lookup. For instance,
  # if you set :request_keys to [:subdomain], :subdomain will be used on authentication.
  # The same considerations mentioned for authentication_keys also apply to request_keys.
  # config.request_keys = []

  # Configure which authentication keys should be case-insensitive.
  # These keys will be downcased upon creating or modifying a user and when used
  # to authenticate or find a user. Default is :email.
  config.case_insensitive_keys = [:email]

  # 配置哪些验证的key需要去掉前后空格
  # Configure which authentication keys should have whitespace stripped.
  # These keys will have whitespace before and after removed upon creating or
  # modifying a user and when used to authenticate or find a user. Default is :email.
  config.strip_whitespace_keys = [:email]

  # Tell if authentication through request.params is enabled. True by default.
  # It can be set to an array that will enable params authentication only for the
  # given strategies, for example, `config.params_authenticatable = [:database]` will
  # enable it only for database (email + password) authentication.
  # config.params_authenticatable = true

  # Tell if authentication through HTTP Auth is enabled. False by default.
  # It can be set to an array that will enable http authentication only for the
  # given strategies, for example, `config.http_authenticatable = [:database]` will
  # enable it only for database authentication. The supported strategies are:
  # :database      = Support basic authentication with authentication key + password
  # config.http_authenticatable = false

  # 配置如果是ajax请求会返回一个401状态码
  # If 401 status code should be returned for AJAX requests. True by default.
  # config.http_authenticatable_on_xhr = true

  # The realm used in Http Basic Authentication. 'Application' by default.
  # config.http_authentication_realm = 'Application'

  # It will change confirmation, password recovery and other workflows
  # to behave the same regardless if the e-mail provided was right or wrong.
  # Does not affect registerable.
  # config.paranoid = true

  # 默认情况下Devise将会把用户信息存储在session中。您可以跳过存储通过设置这个选项来实现特定的策略。
  # 请注意，如果您为所有身份验证路径跳过存储，那么您可能需要对session controller禁止生成路由。
  # By default Devise will store the user in session. You can skip storage for
  # particular strategies by setting this option.
  # Notice that if you are skipping storage for all authentication paths, you
  # may want to disable generating routes to Devise's sessions controller by
  # passing skip: :sessions to `devise_for` in your config/routes.rb
  config.skip_session_storage = [:http_auth]

  # 默认情况下，设备在身份验证时清除CSRF令牌，以避免CSRF令牌固定攻击。这意味着，在使用AJAX请求登录和注册时，
  # 您需要从服务器获得一个新的CSRF令牌。当然选择禁止该选项，不过要承担对应的风险。
  # By default, Devise cleans up the CSRF token on authentication to
  # avoid CSRF token fixation attacks. This means that, when using AJAX
  # requests for sign in and sign up, you need to get a new CSRF token
  # from the server. You can disable this option at your own risk.
  # config.clean_up_csrf_token_on_authentication = true

  # When false, Devise will not attempt to reload routes on eager load.
  # This can reduce the time taken to boot the app but if your application
  # requires the Devise mappings to be loaded during boot time the application
  # won't boot properly.
  # config.reload_routes = true

  # ==> Configuration for :database_authenticatable
  # For bcrypt, this is the cost for hashing the password and defaults to 11. If
  # using other algorithms, it sets how many times you want the password to be hashed.
  #
  # Limiting the stretches to just one in testing will increase the performance of
  # your test suite dramatically. However, it is STRONGLY RECOMMENDED to not use
  # a value less than 10 in other environments. Note that, for bcrypt (the default
  # algorithm), the cost increases exponentially with the number of stretches (e.g.
  # a value of 20 is already extremely slow: approx. 60 seconds for 1 calculation).
  config.stretches = Rails.env.test? ? 1 : 11

  # 设置一个pepper去生成一个哈希密码。
  # Set up a pepper to generate the hashed password.
  # config.pepper = 'e83d8cd4be489ea4f8e024ef66e65595f76144325c2a32fe593eeaf3efcfe539217ab852e71e29aee99b1963723209c5fad3f14ab051018e57b6e2abb94c5437'

  # 用户修改邮箱的时候是否发送一封邮件到原邮箱。
  # Send a notification to the original email when the user's email is changed.
  # config.send_email_changed_notification = false

  # 用户修改密码的时候是否发送一封邮件到其邮箱。
  # Send a notification email when the user's password is changed.
  # config.send_password_change_notification = false

  # ==> Configuration for :confirmable
  # 用户在注册后没有进行确认的时候是否能访问网站，默认是0.days即如果他们没有确认就不能访问。
  # A period that the user is allowed to access the website even without
  # confirming their account. For instance, if set to 2.days, the user will be
  # able to access the website for two days without confirming their account,
  # access will be blocked just in the third day.
  # You can also set it to nil, which will allow the user to access the website
  # without confirming their account.
  # Default is 0.days, meaning the user cannot access the website without
  # confirming their account.
  config.allow_unconfirmed_access_for = 2.days

  # 确认邮件的有效时间设置，默认是nil意味着没有这个确认邮件的有效时间限制。
  # A period that the user is allowed to confirm their account before their
  # token becomes invalid. For example, if set to 3.days, the user can confirm
  # their account within 3 days after the mail was sent, but on the fourth day
  # their account can't be confirmed with the token any more.
  # Default is nil, meaning there is no restriction on how long a user can take
  # before confirming their account.
  config.confirm_within = 3.days

  # 修改邮件的时候需要新邮箱去点击一个确认邮件（和注册的时候一样），如果没有点击确认会把该更新的邮件放到数据库中的一个unconfirmed_email字段内。
  # If true, requires any email changes to be confirmed (exactly the same way as
  # initial account confirmation) to be applied. Requires additional unconfirmed_email
  # db field (see migrations). Until confirmed, new email is stored in
  # unconfirmed_email column, and copied to email column on successful confirmation.
  config.reconfirmable = true

  # Defines which key will be used when confirming an account
  # config.confirmation_keys = [:email]

  # ==> Configuration for :rememberable
  # The time the user will be remembered without asking for credentials again.
  config.remember_for = 2.weeks

  # Invalidates all the remember me tokens when the user signs out.
  config.expire_all_remember_me_on_sign_out = true

  # If true, extends the user's remember period when remembered via cookie.
  # config.extend_remember_period = false

  # Options to be passed to the created cookie. For instance, you can set
  # secure: true in order to force SSL only cookies.
  # config.rememberable_options = {}

  # ==> Configuration for :validatable
  # Range for password length.
  config.password_length = 6..128

  # Email regex used to validate email formats. It simply asserts that
  # one (and only one) @ exists in the given string. This is mainly
  # to give user feedback and not to assert the e-mail validity.
  config.email_regexp = /\A[^@\s]+@[^@\s]+\z/

  # ==> Configuration for :timeoutable
  # 设置不进行活动的情况下超时用户会话的时间，在此之后将要要求用户再次提供凭据。
  # The time you want to timeout the user session without activity. After this
  # time the user will be asked for credentials again. Default is 30 minutes.
  config.timeout_in = 30.minutes

  # ==> Configuration for :lockable
  # 在指定次数的登录尝试失败后锁定帐户。可以通过电子邮件或在指定时间段后解锁。
  # Defines which strategy will be used to lock an account.
  # :failed_attempts = Locks an account after a number of failed attempts to sign in.
  # :none            = No lock strategy. You should handle locking by yourself.
  config.lock_strategy = :failed_attempts

  # Defines which key will be used when locking and unlocking an account
  # config.unlock_keys = [:email]

  # Defines which strategy will be used to unlock an account.
  # 配置解锁策略
  # :email = Sends an unlock link to the user email
  # :time  = Re-enables login after a certain amount of time (see :unlock_in below)
  # :both  = Enables both strategies
  # :none  = No unlock strategy. You should handle unlocking by yourself.
  config.unlock_strategy = :both

  # 配置最多失败多少次后锁定账户
  # Number of authentication tries before locking an account if lock_strategy
  # is failed attempts.
  config.maximum_attempts = 10

  # 配置多长时间后自动解锁
  # Time interval to unlock the account if :time is enabled as unlock_strategy.
  config.unlock_in = 20.minute

  # 在帐户被锁定之前，对最后一次尝试发出警告
  # Warn on the last attempt before the account is locked.
  config.last_attempt_warning = true

  # ==> Configuration for :recoverable
  # 配置重置密码，重置密码和更改密码的区别是，更改密码一般需要知道之前的密码，重置密码相当于找回密码。
  # 定义重置密码的时候使用什么验证
  # Defines which key will be used when recovering the password for an account
  # config.reset_password_keys = [:email]

  # 配置使用重置密码密钥重置您的密码的时间间隔。
  # Time interval you can reset your password with a reset password key.
  # Don't put a too small interval or your users won't have the time to
  # change their passwords.
  config.reset_password_within = 6.hours

  # 设置重置密码后是否自动登录。默认是自动登录
  # When set to false, does not sign a user in automatically after their password is
  # reset. Defaults to true, so a user is signed in automatically after a reset.
  # config.sign_in_after_reset_password = true

  # ==> Configuration for :encryptable
  # 设置允许您使用除bcrypt之外的另一种散列或加密算法
  # Allow you to use another hashing or encryption algorithm besides bcrypt (default).
  # You can use :sha1, :sha512 or algorithms from others authentication tools as
  # :clearance_sha1, :authlogic_sha512 (then you should set stretches above to 20
  # for default behavior) and :restful_authentication_sha1 (then you should set
  # stretches to 10, and copy REST_AUTH_SITE_KEY to pepper).
  #
  # Require the `devise-encryptable` gem when using anything other than bcrypt
  # config.encryptor = :sha512

  # ==> Scopes configuration
  # 如果你的应用程序中有多个Devise模型（例如User和Admin），您会注意到Devise对所有模型使用相同的视图。Devise提供了一种自定义视图的简便方法，
  # 把下面的配置设置成true。这样你将能够基于角色（例如users/sessions/new和admins/sessions/new）进行查看。如果在范围内未找到任何视图，
  # 则Devise将使用默认视图位于devise/sessions/new。
  # Turn scoped views on. Before rendering "sessions/new", it will first check for
  # "users/sessions/new". It's turned off by default because it's slower if you
  # are using only default views.
  # config.scoped_views = false

  # Configure the default scope given to Warden. By default it's the first
  # devise role declared in your routes (usually :user).
  # config.default_scope = :user

  # Set this configuration to false if you want /users/sign_out to sign out
  # only the current scope. By default, Devise signs out all scopes.
  # config.sign_out_all_scopes = true

  # ==> Navigation configuration
  # Lists the formats that should be treated as navigational. Formats like
  # :html, should redirect to the sign in page when the user does not have
  # access, but formats like :xml or :json, should return 401.
  #
  # If you have any extra navigational formats, like :iphone or :mobile, you
  # should add them to the navigational formats lists.
  #
  # The "*/*" below is required to match Internet Explorer requests.
  # config.navigational_formats = ['*/*', :html]

  # 退出登录的时候访问的action
  # The default HTTP method used to sign out a resource. Default is :delete.
  config.sign_out_via = :delete

  # ==> OmniAuth
  # 配置OmniAuth供应商
  # Add a new OmniAuth provider. Check the wiki for more information on setting
  # up on your models and hooks.
  config.omniauth :github, '9211bd36de0022424ad1', 'b0c483a5233b192d8547034d1836dfb39a1e4f5e', scope: "user,repo,gist"
  config.omniauth :wechat, '9211bd36de0022424ad1', 'b0c483a5233b192d8547034d1836dfb39a1e4f5e'

  # ==> Warden configuration
  # If you want to use other strategies, that are not supported by Devise, or
  # change the failure app, you can configure them inside the config.warden block.
  #
  # config.warden do |manager|
  #   manager.intercept_401 = false
  #   manager.default_strategies(scope: :user).unshift :some_external_strategy
  # end

  # ==> Mountable engine configurations
  # When using Devise inside an engine, let's call it `MyEngine`, and this engine
  # is mountable, there are some extra configurations to be taken into account.
  # The following options are available, assuming the engine is mounted as:
  #
  #     mount MyEngine, at: '/my_engine'
  #
  # The router that invoked `devise_for`, in the example above, would be:
  # config.router_name = :my_engine
  #
  # 使用OmniAuth时，设备无法自动设置OmniAuth路径，因此需要手动设置。
  # When using OmniAuth, Devise cannot automatically set OmniAuth path,
  # so you need to do it manually. For the users scope, it would be:
  # config.omniauth_path_prefix = '/my_engine/users/auth'

  # 如果您的应用程序正在使用Turbolinks，则需要包含Turbolinks::Controller以使重定向工作正常
  # ==> Turbolinks configuration
  # If your app is using Turbolinks, Turbolinks::Controller needs to be included to make redirection work correctly:
  #
  ActiveSupport.on_load(:devise_failure_app) do
    include Turbolinks::Controller
  end

  # ==> Configuration for :registerable

  # 用户在更改密码后自动登录，默认是true自动登录。
  # When set to false, does not sign a user in automatically after their password is
  # changed. Defaults to true, so a user is signed in automatically after changing a password.
  # config.sign_in_after_change_password = true
end
