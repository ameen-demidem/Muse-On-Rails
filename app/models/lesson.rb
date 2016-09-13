class Lesson < ApplicationRecord

  belongs_to :student, class_name: "User"
  belongs_to :teacher, class_name: "User"


  attr_accessor :how_many, :how_often, :lesson_date, :recurring

  validates_presence_of :start_time, :end_time, :title, :description

  validate :lessons_cant_overlap
  validate :start_time_before_end_time


  def lessons_cant_overlap
    lesson = Lesson.where("id = ?", id).exists? ? Lesson.find(id) : false
    result = Lesson.all
    result_1 = result.where("start_time >= ? AND start_time <= ?", start_time, end_time).exists?
    result_2 = result.where("start_time <= ? AND end_time >= ?", start_time, start_time).exists?

    if lesson
      if lesson.start_time == start_time
        return
      else lesson.start_time != start_time
        if result_1 || result_2 #false
          errors.add(:lesson, "can't overlap!")
        end
      end
    else
      if result_1 || result_2 #false
        errors.add(:lesson, "can't overlap!")
      end
    end
    
  end

  def start_time_before_end_time
    if start_time > end_time
      errors.add(:lesson, "can't end before they start!")
    end
  end
end
