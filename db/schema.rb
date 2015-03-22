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

ActiveRecord::Schema.define(version: 20150322164051) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "meals", force: :cascade do |t|
    t.integer  "payed_by_id",               null: false
    t.float    "amount",      default: 0.0, null: false
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "meals", ["payed_by_id"], name: "index_meals_on_payed_by_id", using: :btree

  create_table "meals_users", force: :cascade do |t|
    t.integer "meal_id", null: false
    t.integer "user_id", null: false
  end

  add_index "meals_users", ["meal_id"], name: "index_meals_users_on_meal_id", using: :btree
  add_index "meals_users", ["user_id"], name: "index_meals_users_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "username",                 null: false
    t.float    "balance",    default: 0.0, null: false
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "users", ["username"], name: "index_users_on_username", unique: true, using: :btree

  add_foreign_key "meals", "users", column: "payed_by_id"
  add_foreign_key "meals_users", "meals"
  add_foreign_key "meals_users", "users"
end
