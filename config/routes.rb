# == Route Map
#
#                         Prefix Verb     URI Pattern                                                                              Controller#Action
#               new_user_session GET      /users/sign_in(.:format)                                                                 users/sessions#new
#                   user_session POST     /users/sign_in(.:format)                                                                 users/sessions#create
#           destroy_user_session DELETE   /users/sign_out(.:format)                                                                users/sessions#destroy
# user_github_omniauth_authorize GET|POST /users/auth/github(.:format)                                                             users/omniauth_callbacks#passthru
#  user_github_omniauth_callback GET|POST /users/auth/github/callback(.:format)                                                    users/omniauth_callbacks#github
# user_wechat_omniauth_authorize GET|POST /users/auth/wechat(.:format)                                                             users/omniauth_callbacks#passthru
#  user_wechat_omniauth_callback GET|POST /users/auth/wechat/callback(.:format)                                                    users/omniauth_callbacks#wechat
#              new_user_password GET      /users/password/new(.:format)                                                            users/passwords#new
#             edit_user_password GET      /users/password/edit(.:format)                                                           users/passwords#edit
#                  user_password PATCH    /users/password(.:format)                                                                users/passwords#update
#                                PUT      /users/password(.:format)                                                                users/passwords#update
#                                POST     /users/password(.:format)                                                                users/passwords#create
#       cancel_user_registration GET      /users/cancel(.:format)                                                                  users/registrations#cancel
#          new_user_registration GET      /users/sign_up(.:format)                                                                 users/registrations#new
#         edit_user_registration GET      /users/edit(.:format)                                                                    users/registrations#edit
#              user_registration PATCH    /users(.:format)                                                                         users/registrations#update
#                                PUT      /users(.:format)                                                                         users/registrations#update
#                                DELETE   /users(.:format)                                                                         users/registrations#destroy
#                                POST     /users(.:format)                                                                         users/registrations#create
#          new_user_confirmation GET      /users/confirmation/new(.:format)                                                        users/confirmations#new
#              user_confirmation GET      /users/confirmation(.:format)                                                            users/confirmations#show
#                                POST     /users/confirmation(.:format)                                                            users/confirmations#create
#                new_user_unlock GET      /users/unlock/new(.:format)                                                              users/unlocks#new
#                    user_unlock GET      /users/unlock(.:format)                                                                  users/unlocks#show
#                                POST     /users/unlock(.:format)                                                                  users/unlocks#create
#             authenticated_root GET      /                                                                                        static_pages#home
#           unauthenticated_root GET      /                                                                                        users/sessions#new
#                          users GET      /users(.:format)                                                                         users#index
#                                POST     /users(.:format)                                                                         users#create
#                       new_user GET      /users/new(.:format)                                                                     users#new
#                      edit_user GET      /users/:id/edit(.:format)                                                                users#edit
#                           user GET      /users/:id(.:format)                                                                     users#show
#                                PATCH    /users/:id(.:format)                                                                     users#update
#                                PUT      /users/:id(.:format)                                                                     users#update
#                                DELETE   /users/:id(.:format)                                                                     users#destroy
#                    sidekiq_web          /sidekiq                                                                                 Sidekiq::Web
#                   queue_status GET      /queue-status(.:format)                                                                  #<Proc:0x00007fb24cd8bb88@/Users/poly/www/ruby/init_gems/config/routes.rb:87>
#             rails_service_blob GET      /rails/active_storage/blobs/:signed_id/*filename(.:format)                               active_storage/blobs#show
#      rails_blob_representation GET      /rails/active_storage/representations/:signed_blob_id/:variation_key/*filename(.:format) active_storage/representations#show
#             rails_disk_service GET      /rails/active_storage/disk/:encoded_key/*filename(.:format)                              active_storage/disk#show
#      update_rails_disk_service PUT      /rails/active_storage/disk/:encoded_token(.:format)                                      active_storage/disk#update
#           rails_direct_uploads POST     /rails/active_storage/direct_uploads(.:format)                                           active_storage/direct_uploads#create

Rails.application.routes.draw do
  # get 'sessions/create'
  # root 'static_pages#home'
  devise_for :users, module: :users, path_names: {
    sign_in:  'login',
    sign_out: 'logout',
    sign_up:  'register'
  }

  devise_scope :user do
    get 'users/logout', to: "users/sessions#destroy"
    # 登录后的主页变成了 static_pages#home
    authenticated :user do
      root 'static_pages#home', as: :authenticated_root
    end

    # 未登录的话就跳转到登录首页，也就是users/session#new
    unauthenticated do
      root 'users/sessions#new', as: :unauthenticated_root
    end
  end

  resources :users

  # get "/auth/:action/callback", :controller => "authentications", :constraints => { :action => /wechat|github/ }
  # get "/auth/:provider/callback" => "authentications#github"
  # sidekiq的路由相关开始
  # 注意该路由(/sidekiq/stats)可以看到json格式sidekiq的一些状态信息。
  require 'sidekiq/web'

  # 配置sidekiq ui登录的权限，更高级配置可以看文档。
  Sidekiq::Web.use Rack::Auth::Basic do |username, password|
    ActiveSupport::SecurityUtils.secure_compare(::Digest::SHA256.hexdigest(username.to_s), ::Digest::SHA256.hexdigest('admin')) &
        ActiveSupport::SecurityUtils.secure_compare(::Digest::SHA256.hexdigest(password.to_s), ::Digest::SHA256.hexdigest('123456'))
  end
  mount Sidekiq::Web => '/sidekiq'

  # 如果提交表单的时候返回了一个Forbidden错误的话，在rails5.2及以上的版本中进行这样配置。
  Sidekiq::Web.set :session_secret, Rails.application.credentials[:secret_key_base]

  # 如果使用ui的时候session被覆盖重写的话，添加这行命令。
  Sidekiq::Web.set :sessions, false

  # 使用该api后可以通过路由/queue-status去查询'default'队列积压的情况。如果响应为“uhoh”，就会触发一封电子邮件。
  require 'sidekiq/api'
  match "queue-status" => proc { [200, {"Content-Type" => "text/plain"}, [Sidekiq::Queue.new.size < 100 ? "OK" : "UHOH" ]] }, via: :get
  # sidekiq的路由相关结束

end
