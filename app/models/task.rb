class Task < ActiveRecord::Base

  belongs_to :homework, optional: true
  has_many :comments
end
