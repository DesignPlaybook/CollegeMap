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

ActiveRecord::Schema[7.2].define(version: 2025_03_15_074007) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "departments", force: :cascade do |t|
    t.string "name"
    t.string "slug"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["slug"], name: "index_departments_on_slug", unique: true
  end

  create_table "institute_departments", force: :cascade do |t|
    t.integer "institute_id"
    t.integer "department_id"
    t.float "placement_score"
    t.float "higher_studies_score"
    t.float "academics_experience_score"
    t.float "campus_score"
    t.float "entrepreneurship_score"
    t.string "category_slug"
    t.string "gender"
    t.integer "closing_rank"
    t.float "course_length"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_slug"], name: "index_institute_departments_on_category_slug"
    t.index ["closing_rank"], name: "index_institute_departments_on_closing_rank"
    t.index ["department_id"], name: "index_institute_departments_on_department_id"
    t.index ["gender"], name: "index_institute_departments_on_gender"
    t.index ["institute_id"], name: "index_institute_departments_on_institute_id"
  end

  create_table "institutes", force: :cascade do |t|
    t.string "name"
    t.string "slug"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["slug"], name: "index_institutes_on_slug", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "mobile_number", null: false
    t.string "otp"
    t.string "name"
    t.integer "otp_attempts", default: 0
    t.datetime "otp_sent_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["mobile_number"], name: "index_users_on_mobile_number"
  end
end
