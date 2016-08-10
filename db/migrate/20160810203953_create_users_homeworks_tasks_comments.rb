class CreateUsersHomeworksTasksComments < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :username
      t.string :password
      t.string :role
      t.reference :teacher, index: true
    end

    create_table :homeworks do |t|
      t.string :title
      t.string :note
      t.integer :user_id
      t.datetime :created_at
    end

    create_table :tasks do |t|
      t.string :item
      t.string :url
      t.integer :homework_id
      t.boolean :complete
    end

    create_table :comments do |t|
      t.string :feedback
      t.string :url
      t.integer :homework_id
      t.integer :user_id
      t.datetime :created_at
    end
  end
end
