class Comment < ActiveRecord::Base

  belongs_to :task
  belongs_to :user

  has_attached_file :attachment
  validates_attachment_content_type :attachment,
    content_type: /.*/,
    default_url: ""
end
