class Parent::ChildrenController < ApplicationController
  before_action :check_authentication
  before_action :check_authorization

  def index
    @parent = current_user
    @children = current_user.children
    redirect_to parent_child_homeworks_path(@children[0]) if @children.length == 1
  end

  protected

  def check_authorization
    redirect_to root_path unless current_user.role == 'P'
  end
end
