class RemoveHomeworkFromComments < ActiveRecord::Migration[5.0]
  def change
    remove_reference :comments, :homework
  end
end
