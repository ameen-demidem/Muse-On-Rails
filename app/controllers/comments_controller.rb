class CommentsController < ApplicationController
  before_action :check_authentication
  before_action :load_homework
  before_action :is_payment_setup?

  def create
    comment = Comment.new(comment_params)
    comment.user_id = session[:current_user]
    comment.save!
    redirect_to current_user.role == 'S' ?
                  student_homework_path(@homework) :
                  teacher_student_homework_path(@homework.user, @homework)
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
