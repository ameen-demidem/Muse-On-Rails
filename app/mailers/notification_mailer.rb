class NotificationMailer < ApplicationMailer
  default from: 'Bill from Muse <muselessonsapp@gmail.com>'

  def welcome(user)
    @user = user
    mail(to: @user.email, subject: 'Welcome to MUSE lessons!')
  end

  def welcome_student(user)
    @user = user
    mail(to: @user.email, subject: 'Welcome to MUSE lessons!')
  end

  def welcome_parent(user, child_id)
    @user = user
    @child = User.find(child_id)
    mail(to: @user.email, subject: 'Welcome to MUSE lessons!')
  end

  def parent_suspended(user, child)
    @user = user
    @child = child
    mail(to: @user.email, subject: 'Access to muse has been removed')
  end

  def student_suspended(user)
    @user = user
    mail(to: @user.email, subject: 'Access to muse has been removed')
  end

  def student_new_lesson(lesson)
    @lesson = lesson
    @student = User.find(@lesson[:student_id])
    @parent =  @student.parent
    @teacher = @student.teacher
    mail(to: @student.email, subject: 'Your teacher' + @teacher.name + ' has assigned lesson dates!')
  end

  def parent_new_lesson(lesson)
    @lesson = lesson
    @student = User.find(@lesson[:student_id])
    @parent =  @student.parent
    @teacher = @student.teacher
    mail(to: @parent.email, subject: 'Your child ' + @student.name + ' has been assigned lesson dates! by ' + @teacher.name)
  end

end
