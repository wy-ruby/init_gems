Rails.application.config.middleware.use OmniAuth::Builder do
  # provider :developer unless Rails.env.production?
  # provider :twitter, ENV['TWITTER_KEY'], ENV['TWITTER_SECRET']
  provider :github, "9211bd36de0022424ad1", "20a49a878ce7070567da6f7732fc72b8a571cbe7", {scope: "user,repo,gist",
           :provider_ignores_state => true}
  provider :wechat, ENV["WECHAT_APP_ID"], ENV["WECHAT_APP_SECRET"]
end