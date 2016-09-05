class Lesson < ApplicationRecord
  attr_accessor :how_many, :how_often, :lesson_date

  validates_presence_of :start_time, :end_time, :title, :description

  validates :start_time,
    uniqueness: true

  validates :end_time,
    uniqueness: true

  validate :lessons_cant_overlap
  validate :start_time_before_end_time

  def lessons_cant_overlap
    # result   = Event.where("lesson_date = ?", lesson_date)
    result = Lesson.all
    result_1 = result.where("start_time >= ? AND start_time <= ?", start_time, end_time).exists?
    result_2 = result.where("start_time <= ? AND end_time >= ?", start_time, start_time).exists?

    if result_1 || result_2 #false
      errors.add(:lessons, "can't overlap!")
    end

  end

  def start_time_before_end_time
    if start_time >= end_time
      errors.add(:lessons, "can't end before they start!")
    end
  end
end
