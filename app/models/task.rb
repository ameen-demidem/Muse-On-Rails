class Task < ActiveRecord::Base
  attr_accessor :delete_attachment

  belongs_to :homework, optional: true
  has_many :comments

  has_attached_file :attachment
  validates_attachment_content_type :attachment,
    content_type: /.*/,
    default_url: ""
end
