# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_09_30_132556) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "planted_flowers", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "unlockable_flower_id", null: false
    t.datetime "added_at", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["unlockable_flower_id"], name: "index_planted_flowers_on_unlockable_flower_id"
    t.index ["user_id"], name: "index_planted_flowers_on_user_id"
  end

  create_table "self_esteem_trainings", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.datetime "trained_at", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_self_esteem_trainings_on_user_id"
  end

  create_table "unlockable_flowers", force: :cascade do |t|
    t.string "name", null: false
    t.integer "threshold", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "provider"
    t.string "uid", null: false
    t.string "nickname", null: false
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["uid"], name: "index_users_on_uid", unique: true
  end

  add_foreign_key "planted_flowers", "unlockable_flowers"
  add_foreign_key "planted_flowers", "users"
  add_foreign_key "self_esteem_trainings", "users"
end
