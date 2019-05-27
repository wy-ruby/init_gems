class UserMailer < ApplicationMailer
  def welcome_email(user)
    @user = user
    @url  = ENV['TEST_URL']
    mail(to: @user.email, subject: '您好，您已经注册成功！')
  end
end
