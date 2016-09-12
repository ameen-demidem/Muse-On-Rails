class NotificationMailer < ApplicationMailer
  default from: 'Bill <muselessonsapp@gmail.com>'

  def welcome(user)
    @user = user
    mail(to: @user.email, subject: 'Welcome to MUSE lessons!')
  end

  def welcome_student(user)
    @user = user
    mail(to: @user.email, subject: 'Welcome to MUSE lessons!')
  end

  def welcome_parent(user)
    @user = user
    mail(to: @user.email, subject: 'Welcome to MUSE lessons!')
  end

  def parent_suspended(user)
    @user = user
    mail(to: @user.email, subject: 'Access to muse has been removed')
  end

  def student_suspended(user)
    @user = user
    mail(to: @user.email, subject: 'Access to muse has been removed')
  end
end
