class Teacher::LessonsController < ApplicationController
  before_action :set_lesson, only: [:index, :show, :edit, :update, :destroy]
  before_action :check_authentication
  # before_action :check_authorization

  # GET /lessons
  # GET /lessons.json
  def index
    @lessons = Lesson.all
  end

  # GET /lessons/1
  # GET /lessons/1.json
  def show
  end

  # GET /lessons/new
  def new
    @lesson = Lesson.new
  end

  # GET /lessons/1/edit
  def edit
  end

  # POST /lessons
  # POST /lessons.json
  def create
    clean_up_dates(lesson_params)
    if @params[:recurring].to_i > 0
      @recurrences = []
      how_many = (@params[:how_many].to_i > 0) ? (@params[:how_many].to_i - 1) : 52
      @lesson = Lesson.new(@params)
      if @lesson.save
        lesson_start_time = @lesson[:start_time]
        lesson_end_time = @lesson[:end_time]
        id = @lesson[:id]
        how_often = @params[:how_often]

        case how_often
        when "weekly" then create_weekly_occurences(how_many, lesson_start_time, lesson_end_time)
        when "bi-weekly" then create_biweekly_occurences(how_many, lesson_start_time, lesson_end_time)
        when "monthly" then create_monthly_occurences(how_many, lesson_start_time, lesson_end_time)
        end

        @recurrences.each do |lesson|
          new_lesson = Lesson.new(lesson)
          new_lesson.save
        end

        NotificationMailer.student_new_lesson(@lesson).deliver
        NotificationMailer.parent_new_lesson(@lesson).deliver

        respond_to do |format|
          format.html { redirect_to teacher_lessons_path, notice: 'Lesson was successfully created.' }
          format.json { render :show, status: :created, location: @lesson }
        end
      else
        respond_to do |format|
            format.html { render :new }
            format.json { render json: @lesson.errors, status: :unprocessable_entity }
        end
      end
    else
      @lesson = Lesson.new(@params)
      respond_to do |format|
        if @lesson.save

          NotificationMailer.student_new_lesson(@lesson).deliver
          NotificationMailer.parent_new_lesson(@lesson).deliver

          format.html { redirect_to teacher_lessons_path, notice: 'Lesson was successfully created.' }
          format.json { render :show, status: :created, location: @lesson }
        else
          format.html { render :new }
          format.json { render json: @lesson.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PATCH/PUT /lessons/1
  # PATCH/PUT /lessons/1.json
  def update
    clean_up_dates(lesson_params)
    @old_lesson = @lesson.attributes
    respond_to do |format|
      if @lesson.update(@params)

        NotificationMailer.student_update_lesson(@lesson, @old_lesson).deliver
        NotificationMailer.parent_update_lesson(@lesson, @old_lesson).deliver

        format.html { redirect_to teacher_lessons_path, notice: 'Lesson was successfully updated.' }
        format.json { render :show, status: :ok, location: @lesson }
      else
        format.html { render :edit }
        format.json { render json: @lesson.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lessons/1
  # DELETE /lessons/1.json
  def destroy
    NotificationMailer.student_cancelled_lesson(@lesson).deliver
    NotificationMailer.parent_cancelled_lesson(@lesson).deliver
    @lesson.destroy
    respond_to do |format|
      format.html { redirect_to teacher_lessons_url, notice: 'Lesson was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  protected

    def load_student
      @student = User.find_by(id: params[:student_id])
      unless @student
        flash.alert = "Couldn't find the requested student!"
        redirect_to teacher_students_path
      end
    end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_lesson
      @lesson = Lesson.find_by(id: params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def lesson_params
      params.require(:lesson).permit(:title, :description, :lesson_date, :start_time, :end_time, :recurring, :student_id, :teacher_id, :how_many, :how_often)
    end

    def clean_up_dates(params)
     @params = params
     # this is where I fix the start_time date
     @params["start_time(1i)"] = @params["lesson_date(1i)"]
     @params["start_time(2i)"] = @params["lesson_date(2i)"]
     @params["start_time(3i)"] = @params["lesson_date(3i)"]
     # this is where I fix the end_time date
     @params["end_time(1i)"] = @params["lesson_date(1i)"]
     @params["end_time(2i)"] = @params["lesson_date(2i)"]
     @params["end_time(3i)"] = @params["lesson_date(3i)"]

     @params["teacher_id"] = current_user.id

     @params
    end

    def create_weekly_occurences(num, start_time, end_time)
      1.upto(num) do
        start_time += 1.week
        end_time += 1.week
        occurence = @lesson.attributes
        occurence.delete("id")
        occurence.delete("created_at")
        occurence.delete("updated_at")
        occurence["start_time"] = start_time
        occurence["end_time"] = end_time
        @recurrences << occurence
      end
    end

    def create_biweekly_occurences(num, start_time, end_time)
      1.upto(num) do
        start_time += 2.weeks
        end_time += 2.weeks
        occurence = @lesson.attributes
        occurence = @lesson.attributes
        occurence.delete("id")
        occurence.delete("created_at")
        occurence.delete("updated_at")
        occurence["start_time"] = start_time
        occurence["end_time"] = end_time
        @recurrences << occurence
      end
    end

    def create_monthly_occurences(num, start_time, end_time)
      1.upto(num) do
        start_time += 1.month
        end_time += 1.month
        occurence = @lesson.attributes
        occurence.delete("id")
        occurence.delete("created_at")
        occurence.delete("updated_at")
        occurence["start_time"] = start_time
        occurence["end_time"] = end_time
        @recurrences << occurence
      end
    end

end
