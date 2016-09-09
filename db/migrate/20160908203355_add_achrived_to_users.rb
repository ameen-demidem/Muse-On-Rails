class AddAchrivedToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :archived, :boolean
  end
end
