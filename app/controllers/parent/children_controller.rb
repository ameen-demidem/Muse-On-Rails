class Parent::ChildrenController < ApplicationController
  before_action :check_authentication

  def index
    @parent = current_user
    @children = current_user.children
  end

  def show
  end
end
