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

ActiveRecord::Schema.define(version: 20131204002954) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "applicants", force: true do |t|
    t.string   "name"
    t.string   "course"
    t.integer  "ucard"
    t.date     "year"
    t.string   "email"
    t.string   "status"
    t.string   "level"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "boxes", force: true do |t|
    t.string   "name"
    t.string   "barcode"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "copies", force: true do |t|
    t.integer  "item_id"
    t.integer  "box_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "quantity"
  end

  add_index "copies", ["box_id"], name: "index_copies_on_box_id", using: :btree
  add_index "copies", ["item_id"], name: "index_copies_on_item_id", using: :btree

  create_table "fohs", force: true do |t|
    t.string   "position"
    t.integer  "required_number"
    t.integer  "available_number"
    t.datetime "date"
    t.integer  "show_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "fohs", ["show_id"], name: "index_fohs_on_show_id", using: :btree

  create_table "items", force: true do |t|
    t.string   "name"
    t.string   "item_type"
    t.string   "barcode"
    t.float    "price"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "current_level"
  end

  create_table "loans", force: true do |t|
    t.datetime "loan_date"
    t.datetime "expected_date"
    t.datetime "return_date"
    t.string   "student_name"
    t.string   "ucard"
    t.integer  "box_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "returned"
  end

  add_index "loans", ["box_id"], name: "index_loans_on_box_id", using: :btree

  create_table "profiles", force: true do |t|
    t.string   "name"
    t.string   "course"
    t.integer  "ucard"
    t.date     "year"
    t.string   "email"
    t.integer  "applicant_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles", force: true do |t|
    t.string   "name"
    t.string   "position"
    t.integer  "required_number"
    t.integer  "available_number"
    t.integer  "show_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "roles", ["show_id"], name: "index_roles_on_show_id", using: :btree

  create_table "sessions", force: true do |t|
    t.string   "session_id", null: false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], name: "index_sessions_on_session_id", using: :btree
  add_index "sessions", ["updated_at"], name: "index_sessions_on_updated_at", using: :btree

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
    t.string   "type"
    t.datetime "date"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "username",               default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

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
    t.datetime "date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
