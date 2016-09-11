class Task < ActiveRecord::Base

  belongs_to :homework, optional: true
  has_many :comments

  has_attached_file :attachment
  validates_attachment_content_type :attachment, :content_type => /.*/
end
