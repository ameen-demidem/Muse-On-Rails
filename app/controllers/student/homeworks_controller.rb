class Student::HomeworksController < ApplicationController

  def index
  end

  def show
    @homework = Homework.find_by(id: params[:id])
    redirect_to [:student, :homeworks] unless @homework
    redirect_to [:student, :homeworks] unless current_user.homeworks.include? @homework
    @comment = Comment.new
  end
end
