class Task < ActiveRecord::Base

  belongs_to :homework, optional: true
end
