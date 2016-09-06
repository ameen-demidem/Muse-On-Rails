class AddParentToUser < ActiveRecord::Migration[5.0]
  def change
    add_reference :users, :parent, index: true, foreign_key: true
  end
end
