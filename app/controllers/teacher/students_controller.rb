class Teacher::StudentsController < ApplicationController
  before_action :check_authentication
  before_action :check_authorization

  def index
  end
 
  def new
    @parent = User.new
    3.times { @parent.children.build }
  end

  def create
    @parent = User.new(student_params)
    @parent.role = 'P'
    @parent.children.each { |child| child.role = 'S'; child.teacher = current_user }
    if @parent.save
      redirect_to @parent.children.length > 1 ?
        teacher_students_path :
        teacher_student_homeworks_path(@parent.children.first)
    else
      flash.now.alert = "Couldn't create a new student!"
      render action: :new
    end
  end

  def destroy
  end

  protected

  def student_params
    params.require(:user).permit(
      :name, :username, :password,
      children_attributes: [:name, :username, :password]
    )
  end

  def check_authorization
    unless current_user.role == 'T'
      flash.alert = "Unauthorized access!"
      redirect_to root_path
    end
  end
end
