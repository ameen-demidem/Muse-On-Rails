class UsersController < ApplicationController
  def new
    @teacher = User.new
  end

  def create
    @teacher = User.new(user_params.merge!(role: "T"))
    if @teacher.save
      redirect_to [:new, :session]
    else
      render :new
    end
  end

  def destroy
  end

  protected

  def user_params
    params.require(:user).permit(:name, :username, :password)
  end
end
