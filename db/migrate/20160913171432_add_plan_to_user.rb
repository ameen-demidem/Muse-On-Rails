class AddPlanToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :plan, :string
    add_column :users, :rate, :integer
  end
end
