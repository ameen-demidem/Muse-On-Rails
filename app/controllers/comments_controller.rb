class CommentsController < ApplicationController
  before_action :check_authentication
  before_action :load_homework

  def create
    comment = Comment.new(comment_params)
    comment.user_id = session[:current_user]
    comment.save!
    redirect_to [:student, @homework]
  end

  protected

  def comment_params
    params.require(:comment).permit(:feedback, :url, :homework_id)
  end

  def load_homework
    @homework = Homework.find_by(id: params[:comment][:homework_id])
    redirect_to root_path unless @homework
  end
end
