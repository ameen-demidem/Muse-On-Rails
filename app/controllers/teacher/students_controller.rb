class Teacher::StudentsController < ApplicationController
  before_action :check_authentication
  before_action :check_authorization
  before_action :is_payment_setup?

  def index
  end
 
  def new
    @child = User.new
    @parent = @child.build_parent
    @selected_parent = ""
  end

  def create
    child_params = student_params
    parent_id = child_params.delete :parent

    if parent_id != ""
      @parent = User.find_by(id: parent_id)
    else
      @parent = User.new(child_params[:parent_attributes])
      @parent.role = 'P'
    end
    child_params.delete :parent_attributes

    @child = User.new(child_params)
    @child.role = 'S'
    @child.parent = @parent
    @child.teacher = current_user

    if @child.save
      if @parent.save
        redirect_to teacher_student_homeworks_path(@child)
      else
        @selected_parent = ""
        flash.now.alert = "Couldn't create the parent!"
        render action: :new
      end
    else
      @selected_parent = parent_id != "" ? parent_id : ""
      flash.now.alert = "Couldn't create the new student!"
      render action: :new
    end
  end

  def destroy
  end

  protected

  def student_params
    params.require(:user).permit(
      :name, :username, :password, :parent,
      parent_attributes: [:name, :username, :password]
    )
  end

  def check_authorization
    unless current_user.role == 'T'
      flash.alert = "Unauthorized access!"
      redirect_to root_path
    end
  end
end
