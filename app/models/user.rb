class User < ActiveRecord::Base

  has_secure_password

  belongs_to :teacher, class_name: "User", optional: true
  belongs_to :parent, class_name: "User", optional: true


  has_many :students, class_name: "User", foreign_key: "teacher_id"
  has_many :children, class_name: "User", foreign_key: "parent_id"

  accepts_nested_attributes_for :children,
    reject_if:
      proc { |attr| attr[:name].blank? or
             attr[:username].blank? or
             attr[:password].blank?
      }

  def oauth?
    stripe_account_type == 'oauth'
  end

  has_many :homeworks
  has_many :lessons
  has_many :comments, through: :homeworks
  has_many :tasks, through: :homeworks

  validates :name, presence: true
  validates :username, presence: true
end
