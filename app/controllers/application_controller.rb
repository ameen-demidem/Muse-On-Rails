class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user
  helper_method :not_logged_in
  helper_method :teacher?
  
  protected

  def current_user
    User.find_by(id: session[:current_user])
  end

  def not_logged_in
    session[:current_user].nil?
  end

  def teacher?
    current_user.role == 'T'
  end

end
