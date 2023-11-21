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

ActiveRecord::Schema[7.0].define(version: 2023_11_16_125200) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "diaries", force: :cascade do |t|
    t.date "date", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id", "date"], name: "index_diaries_on_user_id_and_date", unique: true
    t.index ["user_id"], name: "index_diaries_on_user_id"
  end

  create_table "diary_entries", force: :cascade do |t|
    t.string "content", null: false
    t.bigint "diary_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["diary_id"], name: "index_diary_entries_on_diary_id"
  end

  create_table "encouragement_requests", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "text", null: false
    t.integer "background_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_encouragement_requests_on_user_id"
  end

  create_table "flowers", force: :cascade do |t|
    t.string "name", null: false
    t.integer "threshold", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "monthly_themes", force: :cascade do |t|
    t.integer "month", null: false
    t.string "title", null: false
    t.text "message", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "planted_flowers", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "flower_id", null: false
    t.datetime "added_at", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["flower_id"], name: "index_planted_flowers_on_flower_id"
    t.index ["user_id"], name: "index_planted_flowers_on_user_id"
  end

  create_table "questions", force: :cascade do |t|
    t.string "text", null: false
    t.integer "score_type", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "recommendations", force: :cascade do |t|
    t.bigint "result_id", null: false
    t.string "title", null: false
    t.text "description", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["result_id"], name: "index_recommendations_on_result_id"
  end

  create_table "results", force: :cascade do |t|
    t.integer "score_range_start", null: false
    t.integer "score_range_end", null: false
    t.text "description", null: false
    t.string "title", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "self_esteem_trainings", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.datetime "trained_at", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_self_esteem_trainings_on_user_id"
  end

  create_table "theme_resources", force: :cascade do |t|
    t.bigint "monthly_theme_id", null: false
    t.string "content", null: false
    t.string "url", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["monthly_theme_id"], name: "index_theme_resources_on_monthly_theme_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "name", null: false
    t.integer "role", default: 0, null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "diaries", "users"
  add_foreign_key "diary_entries", "diaries"
  add_foreign_key "encouragement_requests", "users"
  add_foreign_key "planted_flowers", "flowers"
  add_foreign_key "planted_flowers", "users"
  add_foreign_key "recommendations", "results"
  add_foreign_key "self_esteem_trainings", "users"
  add_foreign_key "theme_resources", "monthly_themes"
end
