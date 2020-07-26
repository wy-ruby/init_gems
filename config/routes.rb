# == Route Map
#
#                         Prefix Verb     URI Pattern                                                                              Controller#Action
#               new_user_session GET      /users/login(.:format)                                                                   users/sessions#new
#                   user_session POST     /users/login(.:format)                                                                   users/sessions#create
#           destroy_user_session DELETE   /users/logout(.:format)                                                                  users/sessions#destroy
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
#          new_user_registration GET      /users/register(.:format)                                                                users/registrations#new
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
#                   users_logout GET      /users/logout(.:format)                                                                  users/sessions#destroy
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
#                   queue_status GET      /queue-status(.:format)                                                                  #<Proc:0x00007ff15863dbd8@(eval):19>
#                                GET      /*unmatched_route(.:format)                                                              application#route_not_found
#             rails_service_blob GET      /rails/active_storage/blobs/:signed_id/*filename(.:format)                               active_storage/blobs#show
#      rails_blob_representation GET      /rails/active_storage/representations/:signed_blob_id/:variation_key/*filename(.:format) active_storage/representations#show
#             rails_disk_service GET      /rails/active_storage/disk/:encoded_key/*filename(.:format)                              active_storage/disk#show
#      update_rails_disk_service PUT      /rails/active_storage/disk/:encoded_token(.:format)                                      active_storage/disk#update
#           rails_direct_uploads POST     /rails/active_storage/direct_uploads(.:format)                                           active_storage/direct_uploads#create

Rails.application.routes.draw do
  def draw(routes_name)
    instance_eval(File.read(Rails.root.join("config/routes/#{routes_name}.rb")))
  end

  # 配置 +devise+ 相关的路由
  draw :devise

  resources :users

  # 配置 +sidekiq+ 相关的路由
  draw :sidekiq

  # 配置 +api+ 相关的路由
  draw :api

  # 匹配未定义的路由到 application下的route_not_found 方法中。
  get '*unmatched_route', to: 'application#route_not_found'
end
