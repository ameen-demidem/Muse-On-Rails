class Teacher::StudentsController < ApplicationController
  before_action :check_authentication
  before_action :check_authorization
  before_action :is_payment_setup?
  before_action :load_student, only: [:edit, :show, :update, :destroy]

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

  def edit

  end

  def destroy
  end

  def archived_students
    # renders payment.html.erb
  end

  protected

  def student_params
    params.require(:user).permit(
      :name, :username, :password,
      children_attributes: [:name, :username, :password, :archived?]
    )
  end

  def check_authorization
    unless current_user.role == 'T'
      flash.alert = "Unauthorized access!"
      redirect_to root_path
    end
  end

  def load_student
    @student = User.find_by(id: params[:id])
    unless @student
      flash.alert = "Couldn't find the requested student!"
      redirect_to teacher_students_path
    end
  end
end
