class Teacher::StudentsController < ApplicationController
  before_action :check_authentication
  before_action :check_authorization
  before_action :is_payment_setup?

  def index
  end
 
  def new
    @student = User.new
  end

  def create
    @student = User.new(student_params)
    @student.role = 'S'
    @student.teacher = current_user
    if @student.save
      redirect_to teacher_student_homeworks_path(@student)
    else
      flash.now.alert = "Couldn't create a new student!"
      render action: :new
    end
  end

  def destroy
  end

  protected

  def student_params
    params.require(:user).permit(:name, :username, :password)
  end

  def check_authorization
    unless current_user.role == 'T'
      flash.alert = "Unauthorized access!"
      redirect_to root_path
    end
  end
end
