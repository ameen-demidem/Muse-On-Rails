class SessionsController < ApplicationController
  def new
    if current_user
      if current_user.role = "T"
        redirect_to "/teacher/students"
      elsif current_user.role = "S"
        redirect_to "/student"
      else
        redirect_to "/logout"
      end
    end
  end

  def create
    username, password = params[:username], params[:password]
    user = User.find_by(username: username).try(:authenticate, password)
    if user
      session.delete(:error)
      session[:current_user] = user.id
      user.role == 'T' ? redirect_to('/teacher/students'): redirect_to('/student')
    else
      session.delete(:current_user)
      session[:error] = "Wrong username or password!"
      redirect_to new_session_path
    end
  end

  def destroy
    session[:current_user] = nil
    redirect_to root_path
  end
end
