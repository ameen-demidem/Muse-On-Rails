# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160910205323) do

  create_table "comments", force: :cascade do |t|
    t.string   "feedback"
    t.string   "url"
    t.integer  "user_id"
    t.datetime "created_at"
    t.integer  "task_id"
    t.index ["task_id"], name: "index_comments_on_task_id"
  end

  create_table "homeworks", force: :cascade do |t|
    t.string   "title"
    t.string   "note"
    t.integer  "user_id"
    t.datetime "created_at"
  end

  create_table "lessons", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.datetime "start_time"
    t.datetime "end_time"
    t.integer  "student_id"
    t.integer  "teacher_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "tasks", force: :cascade do |t|
    t.string  "item"
    t.string  "url"
    t.integer "homework_id"
    t.boolean "complete"
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "username"
    t.string   "password_digest"
    t.string   "role",                  limit: 1
    t.integer  "teacher_id"
    t.integer  "parent_id"
    t.string   "stripe_token"
    t.string   "publishable_key"
    t.string   "secret_key"
    t.string   "stripe_user_id"
    t.string   "stripe_account_type"
    t.string   "currency"
    t.text     "stripe_account_status",           default: "{}"
    t.boolean  "archived"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "age"
    t.string   "level"
    t.string   "instrument"
    t.index ["parent_id"], name: "index_users_on_parent_id"
    t.index ["teacher_id"], name: "index_users_on_teacher_id"
  end

end
