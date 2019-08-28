class UserMailer < ApplicationMailer
  # 发送邮件的时候使用UserMailer.welcome_email(@user).deliver执行邮发送。
  # 使用deliver可以直接发送邮件。
  # 使用deliver_now立即发送邮件，但是并不是异步发送，并且无法使用sidekiq作为发送连接器。
  # 使用deliver_later是异步发送，并且能使用配置的sidekiq连接器。
  def welcome_email(user)
    @user = user
    @url  = Rails.application.credentials[:test_url]
    mail(to: @user.email, subject: '您好，您已经注册成功！')
  end
end
