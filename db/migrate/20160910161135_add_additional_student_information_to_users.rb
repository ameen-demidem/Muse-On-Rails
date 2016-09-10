class AddAdditionalStudentInformationToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :age, :integer
    add_column :users, :level, :string
    add_column :users, :instrument, :string
  end
end
