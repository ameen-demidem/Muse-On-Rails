class Teacher::HomeworksController < ApplicationController
  before_action :check_authentication
  before_action :check_authorization
  before_action :load_student
  before_action :load_homework, only: [:edit, :show, :update, :destroy]
  before_action :check_requestdata_sanity

  def index
  end

  def show
    @comment = Comment.new
  end

  def new
    @homework = Homework.new
  end

  def edit
    @new_task = @homework.tasks.build
  end

  def create
    @homework = Homework.new(homework_params)
    @homework.user = @student
    if @homework.save
      redirect_to edit_teacher_student_homework_path(@student, @homework)
    else
      flash.now.alert = "Couldn't create the new homework!"
      render :new
    end
  end

  def update
    puts "Processing update request: #{homework_params.inspect}"
    homework_params[:tasks_attributes].each { |k,v| puts "Task #{k} : #{v.inspect}" }
    @homework.update_attributes(homework_params)
    redirect_to teacher_student_homework_path(@homework)
  end

  def destroy
  end

  protected

  def homework_params
    params.require(:homework).permit(:title, :note, tasks_attributes: [:id, :item, :url])
  end

  def check_authorization
    unless current_user.role == 'T'
      flash.alert = "Unauthorized access!"
      redirect_to root_path
    end
  end
  
  def load_student
    @student = User.find_by(id: params[:student_id])
    unless @student
      flash.alert = "Couldn't find the requested student!"
      redirect_to teacher_students_path
    end
  end

  def load_homework
    @homework = Homework.find_by(id: params[:id])
    unless @homework
      flash.alert = "Couldn't find the requested homework!"
      redirect_to teacher_student_homeworks_path(@student)
    end
  end

  def check_requestdata_sanity
    if @student.teacher != current_user
      flash.alert = "Unauthorized access to the records of the student!"
      redirect_to teacher_students_path
    elsif (@homework and @homework.user != @student)
      flash.alert = "Requested the wrong homework for the student!"
      redirect_to teacher_student_homeworks_path(@student)
    end
  end
end
