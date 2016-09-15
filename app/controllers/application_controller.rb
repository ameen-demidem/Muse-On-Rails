class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user
  helper_method :not_logged_in
  helper_method :teacher?
  helper_method :student?
  helper_method :parent?
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

  def parent?
    current_user.role == 'P'
  end

  def archived_students?
    current_user.students.where("archived = ?", true).length
  end

  def youtube?(url)
    url =~ /(youtube|youtu.be)/
  end

  def image?(url)
    url.downcase =~ /\.jpg$|\.jpeg$|\.png$/
  end

  def video?(url)
    url.downcase =~ /\.mpg$|\.mpeg$|\.mp4$|\.webm$|\.ogg$/
  end

  def youtubify(url, content_type = nil)
    youtube_iframe =  "<div class='col s12'>" +
                        "<div class='video-container'>" +
                          "<iframe " +
                            "src='#{url.sub(/watch\?v=/, "embed/")}' " +
                            "frameborder='0' allowfullscreen>" +
                          "</iframe>" +
                        "</div>" +
                      "</div>"
    image_link =  "<div class='col s8'>" +
                    "<img class='responsive-img' src=#{url}>" +
                  "</div>"
    video_link =  "<div class='col s12'>" +
                    "<video class='responsive-video' controls>" +
                      "<source src=#{url}>" +
                      "Your browser does not support HTML5 video." +
                    "</video>" +
                  "</div>"
      regular_link = "<a href='#{url}'>Check this link!</a>"

    case content_type
    when /video.*/
      link = video_link
    when /image.*/
      link = image_link
    else
      link = if youtube?(url) then youtube_iframe
             elsif image?(url) then image_link
             elsif video?(url) then video_link
             else regular_link;
             end
    end

    link.html_safe
  end

end
