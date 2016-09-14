class AddAttachmentToComments < ActiveRecord::Migration[5.0]
  def change
    add_attachment :comments, :attachment
  end
end
