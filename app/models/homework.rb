class Homework < ActiveRecord::Base

  belongs_to :user
  
  has_many :tasks
  has_many :comments

  accepts_nested_attributes_for :tasks, reject_if: proc { |attributes| attributes['item'] == "" }

  validates :title, :note,
    presence: true
end
