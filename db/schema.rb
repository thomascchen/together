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

ActiveRecord::Schema.define(version: 20150717164657) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "buildings", force: :cascade do |t|
    t.string   "street",          null: false
    t.string   "city",            null: false
    t.string   "state",           null: false
    t.string   "zip",             null: false
    t.integer  "neighborhood_id", null: false
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "categories", force: :cascade do |t|
    t.string "name", null: false
  end

  create_table "neighborhoods", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "problem_votes", force: :cascade do |t|
    t.integer "user_id",    null: false
    t.integer "problem_id", null: false
  end

  create_table "problems", force: :cascade do |t|
    t.string   "title",                        null: false
    t.text     "description",                  null: false
    t.integer  "category_id",                  null: false
    t.integer  "urgency_level_id",             null: false
    t.integer  "status_id",        default: 1, null: false
    t.integer  "user_id",                      null: false
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  create_table "solutions", force: :cascade do |t|
    t.string   "title",                       null: false
    t.text     "description",                 null: false
    t.boolean  "accepted",    default: false, null: false
    t.integer  "user_id",                     null: false
    t.integer  "problem_id",                  null: false
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "statuses", force: :cascade do |t|
    t.string "name", null: false
  end

  create_table "urgency_levels", force: :cascade do |t|
    t.string "name", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "first_name",                                null: false
    t.string   "last_name",                                 null: false
    t.string   "unit",                                      null: false
    t.string   "role",                   default: "tenant", null: false
    t.integer  "building_id",                               null: false
    t.integer  "neighborhood_id",                           null: false
    t.string   "avatar_url"
    t.string   "phone"
    t.text     "description"
    t.string   "email",                  default: "",       null: false
    t.string   "encrypted_password",     default: "",       null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,        null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
