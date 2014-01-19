# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20140119161048) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "fohs", force: true do |t|
    t.integer  "show_date_id"
    t.integer  "position_id"
    t.integer  "user_id"
    t.string   "phone_number"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "fohs", ["show_date_id"], name: "index_fohs_on_show_date_id", using: :btree
  add_index "fohs", ["user_id"], name: "index_fohs_on_user_id", using: :btree

  create_table "positions", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles_users", id: false, force: true do |t|
    t.integer "role_id"
    t.integer "user_id"
  end

  create_table "sessions", force: true do |t|
    t.string   "session_id", null: false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], name: "index_sessions_on_session_id", using: :btree
  add_index "sessions", ["updated_at"], name: "index_sessions_on_updated_at", using: :btree

  create_table "show_dates", force: true do |t|
    t.date     "date"
    t.time     "time"
    t.integer  "show_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "show_dates", ["show_id"], name: "index_show_dates_on_show_id", using: :btree

  create_table "show_roles", force: true do |t|
    t.string   "name"
    t.string   "position"
    t.integer  "required_number"
    t.integer  "available_number"
    t.integer  "show_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "show_roles", ["show_id"], name: "index_show_roles_on_show_id", using: :btree

  create_table "shows", force: true do |t|
    t.string   "name"
    t.string   "image"
    t.string   "director"
    t.string   "stage_manager"
    t.string   "producer"
    t.text     "synopsis"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "socials", force: true do |t|
    t.string   "title"
    t.text     "location"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "date"
    t.time     "time"
    t.integer  "duration"
  end

  create_table "training_attendances", force: true do |t|
    t.string   "username"
    t.string   "recorder"
    t.integer  "training_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "training_attendances", ["training_id"], name: "index_training_attendances_on_training_id", using: :btree

  create_table "trainings", force: true do |t|
    t.string   "title"
    t.string   "category"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "date"
    t.time     "time"
    t.integer  "duration"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "firstname"
    t.string   "lastname"
    t.string   "ucard"
    t.string   "course"
    t.boolean  "approved",               default: false, null: false
    t.string   "level"
  end

  add_index "users", ["approved"], name: "index_users_on_approved", using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "workshop_attendances", force: true do |t|
    t.string   "username"
    t.string   "recorder"
    t.integer  "workshop_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "workshop_attendances", ["workshop_id"], name: "index_workshop_attendances_on_workshop_id", using: :btree

  create_table "workshops", force: true do |t|
    t.string   "title"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "date"
    t.time     "time"
    t.integer  "duration"
  end

end
