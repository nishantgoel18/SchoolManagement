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

ActiveRecord::Schema[7.0].define(version: 2023_08_17_035125) do
  create_table "batches", force: :cascade do |t|
    t.integer "school_id"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "course_id"
    t.index ["course_id"], name: "index_batches_on_course_id"
    t.index ["school_id"], name: "index_batches_on_school_id"
  end

  create_table "courses", force: :cascade do |t|
    t.string "name"
    t.integer "school_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["school_id"], name: "index_courses_on_school_id"
  end

  create_table "enrollments", force: :cascade do |t|
    t.integer "user_id"
    t.integer "batch_id"
    t.string "status", default: "Pending"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["batch_id"], name: "index_enrollments_on_batch_id"
    t.index ["user_id"], name: "index_enrollments_on_user_id"
  end

  create_table "schools", force: :cascade do |t|
    t.string "name"
    t.text "address"
    t.text "about"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.string "authentication_token"
    t.string "type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "school_id"
    t.index ["authentication_token"], name: "index_users_on_authentication_token"
    t.index ["email"], name: "index_users_on_email"
    t.index ["school_id"], name: "index_users_on_school_id"
  end

end
