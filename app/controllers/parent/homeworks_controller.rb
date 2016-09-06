class Parent::HomeworksController < ApplicationController
  before_action :check_authentication
  before_action :check_authorization
  before_action :load_child
  before_action :load_homework, only: [:show]
  before_action :check_requestdata_sanity, only: [:show]

  def index
    @parent = current_user
  end

  def show
    @parent = current_user
  end

  protected

  def check_authorization
    redirect_to root_path unless current_user.role == 'P'
  end

  def load_child
    @child = User.find_by(id: params[:child_id])
    redirect_to parent_children_path unless @child.parent == current_user
  end

  def load_homework
    @homework = Homework.find_by(id: params[:id])
    redirect_to parent_child_homeworks_path(@child) unless @homework
  end

  def check_requestdata_sanity
    redirect_to parent_children_path unless @homework.user == @child
  end
end
