class UserMailer < ApplicationMailer
  def welcome_email(user)
    @user = user
    @url  = Rails.application.credentials[:test_url]
    mail(to: @user.email, subject: '您好，您已经注册成功！')
  end
end
