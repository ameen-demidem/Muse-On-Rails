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
    #TODO implement the deletion of a user
  end

  def payment
    # renders payment.html.erb
  end

  def pay
    puts params
  end

  protected

  def user_params
    params.require(:user).permit(:name, :username, :password)
  end

  def process_payment
    # TODO: implement
  end
end
