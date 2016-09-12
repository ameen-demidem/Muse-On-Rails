class NotificationMailer < ApplicationMailer
  default from: 'Bill <muselessonsapp@gmail.com>'

  def welcome(user)
    @user = user
    mail(to: @user.email, subject: 'Welcome to MUSE lessons!')
  end
end
