# get "/auth/:action/callback", :controller => "authentications", :constraints => { :action => /wechat|github/ }
# get "/auth/:provider/callback" => "authentications#github"

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