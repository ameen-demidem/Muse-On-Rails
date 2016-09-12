class Teacher::StudentsController < ApplicationController
  before_action :check_authentication
  before_action :check_authorization
  before_action :is_payment_setup?
  before_action :load_student, only: [:edit, :show, :update, :destroy]

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

  def edit
  end

  def update
    child_params = student_params
    parent_id = child_params.delete :parent
    if parent_id != ""
      @parent = User.find_by(id: parent_id)
    else
      @parent = User.new(child_params[:parent_attributes])
      @parent.role = 'P'
    end
    child_params.delete :parent_attributes

    respond_to do |format|
      if @student.update(child_params)
        format.html { redirect_to teacher_students_path, notice: 'Student information has been updated.' }
        format.json { render :show, status: :ok, location: @student }
      else
        format.html { render :edit }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
  end

  def archived_students
  end

  protected

  def student_params
    params.require(:user).permit(
      :name, :username, :password, :parent, :archived, :age, :level, :instrument, :email,
      parent_attributes: [:name, :username, :password, :archived, :email]
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
