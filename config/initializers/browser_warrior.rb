# 该gem是根据browser这个gem扩展的，设置的过程中可以参考browser这个gem。
BrowserWarrior.detect do |browser|
  next true if Rails.env.test?
  next true if browser.bot?

  next true unless browser.known?

  # Allow weixin callback
  next true if browser.platform.other?

  # See https://github.com/fnando/browser#usage for more usage
  next true if browser.wechat?
  next true if browser.weibo?
  next true if browser.facebook?

  # Block known non-modern browser
  next false if browser.chrome?("<= 65")
  next false if browser.safari?("< 10")
  next false if browser.firefox?("< 52")
  next false if browser.ie?("< 11")
  next false if browser.edge?("< 15")
  next false if browser.opera?("< 50")

  # Allow by default
  next true
end
