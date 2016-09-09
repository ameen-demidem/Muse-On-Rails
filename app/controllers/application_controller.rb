class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user
  helper_method :not_logged_in
  helper_method :teacher?
  helper_method :student?
  helper_method :youtubify
  helper_method :archived_students?
  helper_method :archived_check

  protected

  def current_user
    User.find_by(id: session[:current_user])
  end

  def not_logged_in
    session[:current_user].nil?
  end

  def check_authentication
    unless current_user
      flash.alert = "Unauthorized access!"
      redirect_to root_path
    end
  end

  def is_payment_setup?
    if (current_user.role == 'T') && (current_user.stripe_token.nil?)
      redirect_to users_payment_path
    end
  end

  def teacher?
    current_user.role == 'T'
  end

  def student?
    current_user.role == 'S'
  end

  def archived_students?
    current_user.students.where("archived = ?", true).length
  end

  def archived_check
    if current_user.archived?
      flash.alert = "Currently not allowed to use the system." +
      " Please follow-up with your reacher for more information"
      redirect_to root_path
    end
  end

  def youtube?(url)
    url =~ /(youtube|youtu.be)/
  end

  def youtubify(url)
    youtube_iframe = "<iframe width='400' height='300' " +
                             "src='#{url.sub(/watch\?v=/, "embed/")}' " +
                             "frameborder='0' allowfullscreen>" +
                     "</iframe>"
    regular_link = "<a href='#{url}'>Resources ...</a>"

    link = youtube?(url) ? youtube_iframe : regular_link
    link.html_safe
  end

end
