Rails.application.config.middleware.use OmniAuth::Builder do
  # provider :developer unless Rails.env.production?
  # provider :github, "9211bd36de0022424ad1", "b0c483a5233b192d8547034d1836dfb39a1e4f5e", {scope: "user,repo,gist"}
  # provider :wechat, "9211bd36de0022424ad1", "b0c483a5233b192d8547034d1836dfb39a1e4f5e", {scope: "user,repo,gist"}
  # on_failure { |env| AuthenticationsController.action(:failure).call(env) }
end