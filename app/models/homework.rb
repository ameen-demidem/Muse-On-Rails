class Homework < ActiveRecord::Base

  belongs_to :user
  
  has_many :tasks
  has_many :comments, through: :tasks

  accepts_nested_attributes_for :tasks,
    allow_destroy: true,
    reject_if: proc { |attributes| attributes['item'] == "" }

  validates :title, :note,
    presence: true
end
