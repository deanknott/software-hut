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

ActiveRecord::Schema.define(version: 2019_05_16_014007) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "account_privacies", force: :cascade do |t|
    t.string "privacy_level", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "blogs", force: :cascade do |t|
    t.string "name"
    t.bigint "member_id", null: false
    t.bigint "privacy_id", null: false
    t.text "content", null: false
    t.string "file"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["member_id"], name: "index_blogs_on_member_id"
    t.index ["privacy_id"], name: "index_blogs_on_privacy_id"
  end

  create_table "courses", force: :cascade do |t|
    t.string "name", null: false
    t.bigint "department_id"
    t.text "description"
    t.bigint "delivery_mode_id"
    t.boolean "full_time"
    t.string "location"
    t.integer "length"
    t.string "ucas_url"
    t.text "notes"
    t.bigint "end_qualification_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "institute_url"
    t.string "start_date"
    t.string "code", null: false
    t.string "entry_requirements_info"
    t.string "fees_info"
    t.index ["delivery_mode_id"], name: "index_courses_on_delivery_mode_id"
    t.index ["department_id"], name: "index_courses_on_department_id"
    t.index ["end_qualification_id"], name: "index_courses_on_end_qualification_id"
  end

  create_table "courses_eligibilities", id: false, force: :cascade do |t|
    t.bigint "course_id"
    t.bigint "eligibility_requirement_id"
    t.index ["course_id"], name: "index_courses_eligibilities_on_course_id"
    t.index ["eligibility_requirement_id"], name: "index_courses_eligibilities_on_eligibility_requirement_id"
  end

  create_table "courses_wps", id: false, force: :cascade do |t|
    t.bigint "course_id"
    t.bigint "wp_id"
    t.index ["course_id"], name: "index_courses_wps_on_course_id"
    t.index ["wp_id"], name: "index_courses_wps_on_wp_id"
  end

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer "priority", default: 0, null: false
    t.integer "attempts", default: 0, null: false
    t.text "handler", null: false
    t.text "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string "locked_by"
    t.string "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["priority", "run_at"], name: "delayed_jobs_priority"
  end

  create_table "delivery_modes", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "departments", force: :cascade do |t|
    t.string "name", null: false
    t.string "phone_number"
    t.string "email"
    t.string "url"
    t.bigint "institution_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["institution_id"], name: "index_departments_on_institution_id"
  end

  create_table "eligibility_requirements", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "end_qualifications", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_end_qualifications_on_name", unique: true
  end

  create_table "entry_requirements", force: :cascade do |t|
    t.bigint "course_id", null: false
    t.bigint "incoming_qualification_id", null: false
    t.string "grade", null: false
    t.string "info"
    t.index ["course_id"], name: "index_entry_requirements_on_course_id"
    t.index ["incoming_qualification_id"], name: "index_entry_requirements_on_incoming_qualification_id"
  end

  create_table "fees", force: :cascade do |t|
    t.bigint "course_id", null: false
    t.bigint "student_type_id", null: false
    t.integer "fee", null: false
    t.string "time_period"
    t.index ["course_id"], name: "course_id"
    t.index ["student_type_id"], name: "student_type_id"
  end

  create_table "incoming_qualifications", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_incoming_qualifications_on_name", unique: true
  end

  create_table "institutions", force: :cascade do |t|
    t.string "name", null: false
    t.text "website"
    t.string "phone_number"
    t.text "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_institutions_on_name", unique: true
  end

  create_table "members", force: :cascade do |t|
    t.string "title"
    t.string "name", null: false
    t.string "job"
    t.text "bio"
    t.bigint "institution_id", null: false
    t.bigint "role_id", null: false
    t.bigint "account_privacy_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "email_privacy_id", null: false
    t.bigint "bio_privacy_id", null: false
    t.bigint "job_privacy_id", null: false
    t.index ["account_privacy_id"], name: "index_members_on_account_privacy_id"
    t.index ["bio_privacy_id"], name: "index_members_on_bio_privacy_id"
    t.index ["email_privacy_id"], name: "index_members_on_email_privacy_id"
    t.index ["institution_id"], name: "index_members_on_institution_id"
    t.index ["job_privacy_id"], name: "index_members_on_job_privacy_id"
    t.index ["role_id"], name: "index_members_on_role_id"
  end

  create_table "privacies", force: :cascade do |t|
    t.string "level", null: false
  end

  create_table "roles", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_roles_on_name", unique: true
  end

  create_table "search_suggestions", force: :cascade do |t|
    t.string "term"
    t.integer "popularity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sessions", force: :cascade do |t|
    t.string "session_id", null: false
    t.text "data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["session_id"], name: "index_sessions_on_session_id", unique: true
    t.index ["updated_at"], name: "index_sessions_on_updated_at"
  end

  create_table "static_pages", force: :cascade do |t|
    t.string "name", null: false
    t.text "contents", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "custom_file"
  end

  create_table "stored_searches", force: :cascade do |t|
    t.string "email", null: false
    t.string "name"
    t.string "institution"
    t.integer "length"
    t.bigint "delivery_mode_id"
    t.boolean "full_time"
    t.integer "distance"
    t.string "location"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["delivery_mode_id"], name: "index_stored_searches_on_delivery_mode_id"
  end

  create_table "student_types", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_student_types_on_name", unique: true
  end

  create_table "users", id: false, force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.bigint "member_id"
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["member_id"], name: "index_users_on_member_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "wps", force: :cascade do |t|
    t.string "wp_type", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "blogs", "members"
  add_foreign_key "blogs", "privacies"
  add_foreign_key "courses", "delivery_modes"
  add_foreign_key "courses", "departments"
  add_foreign_key "courses_eligibilities", "courses"
  add_foreign_key "courses_eligibilities", "eligibility_requirements"
  add_foreign_key "courses_wps", "courses"
  add_foreign_key "courses_wps", "wps"
  add_foreign_key "departments", "institutions"
  add_foreign_key "entry_requirements", "courses"
  add_foreign_key "entry_requirements", "incoming_qualifications"
  add_foreign_key "fees", "courses"
  add_foreign_key "fees", "student_types"
  add_foreign_key "members", "account_privacies"
  add_foreign_key "members", "institutions"
  add_foreign_key "members", "roles"
  add_foreign_key "users", "members"
end
