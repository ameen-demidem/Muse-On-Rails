class TasksController < ApplicationController
  before_action :check_authentication
  before_action :check_authorization, only: [:create]
  before_action :load_homework
  before_action :load_task, only: [:update]
  before_action :check_update_data_sanity, only: [:update]

  def create
    task = Comment.new(comment_params)
    task.user_id = session[:current_user]
    task.save!
    redirect_to [:student, @homework]
  end

  def update
    @task.complete = params[:done]
    @task.save
  end

  protected

  def task_params
#    params.permit(:homework_id, :task_id, :done)
  end

  def load_homework
    @homework = Homework.find_by(id: params[:homework_id])
    unless @homework
      flash.alert = "Could not create or update a task for a non-existing homework!"
      redirect_to root_path 
    end
  end

  def load_task
    @task = Task.find_by(id: params[:task_id])
    unless @task
      flash.alert = "Could not load the task for update!"
      redirect_to root_path 
    end
  end

  def check_authorization
    unless current_user.role == 'T'
      flash.alert = "Unauthorized access!"
      redirect_to root_path
    end
  end

  def check_update_data_sanity
    unless @homework.tasks.include? @task
      flash.alert = "Trying to update a non valid task for the homework!"
      redirect_to root_path 
    end
  end
end
