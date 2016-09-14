class AddAttachmentToTasks < ActiveRecord::Migration[5.0]
  def change
    add_attachment :tasks, :attachment
  end
end
