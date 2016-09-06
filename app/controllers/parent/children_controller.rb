class Parent::ChildrenController < ApplicationController
  before_action :check_authentication
  before_action :check_authorization
  before_action :load_child, only: [:show]

  def index
    @parent = current_user
    @children = current_user.children
  end

  def show
    @parent = current_user
  end

  protected

  def check_authorization
  end

  def load_child
    @child = User.find_by(id: params[:id])
    redirect_to parent_children_path unless @child.parent == current_user
  end
end
