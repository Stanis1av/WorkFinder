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

ActiveRecord::Schema.define(version: 2022_06_11_051451) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "action_text_rich_texts", force: :cascade do |t|
    t.string "name", null: false
    t.text "body"
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["record_type", "record_id", "name"], name: "index_action_text_rich_texts_uniqueness", unique: true
  end

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
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "educations", force: :cascade do |t|
    t.string "level_of_education"
    t.string "field_of_study"
    t.string "school_name"
    t.string "country"
    t.string "city_or_state"
    t.boolean "currently_enrolled"
    t.datetime "from"
    t.datetime "to"
    t.bigint "resume_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["resume_id"], name: "index_educations_on_resume_id"
  end

  create_table "employers", force: :cascade do |t|
    t.string "name"
    t.text "about_employer"
    t.string "website"
    t.string "email"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_employers_on_user_id"
  end

  create_table "job_seekers", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.string "phone_number"
    t.integer "age"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_job_seekers_on_user_id"
  end

  create_table "locations", force: :cascade do |t|
    t.string "country_of_residence"
    t.string "city_or_state_of_residence"
    t.bigint "job_seeker_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["job_seeker_id"], name: "index_locations_on_job_seeker_id"
  end

  create_table "resume_skills", force: :cascade do |t|
    t.bigint "skill_id", null: false
    t.bigint "resume_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["resume_id"], name: "index_resume_skills_on_resume_id"
    t.index ["skill_id"], name: "index_resume_skills_on_skill_id"
  end

  create_table "resumes", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.integer "age"
    t.string "headline"
    t.string "country_of_residence"
    t.string "city_or_state_of_residence"
    t.boolean "relocation"
    t.boolean "remote"
    t.string "email"
    t.string "phone_number"
    t.bigint "job_seeker_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["job_seeker_id"], name: "index_resumes_on_job_seeker_id"
  end

  create_table "skills", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "slug"
    t.index ["slug"], name: "index_skills_on_slug", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.string "role"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "vacancies", force: :cascade do |t|
    t.string "job_title"
    t.string "company_name"
    t.string "country"
    t.string "location"
    t.boolean "remote"
    t.string "type_of_job"
    t.string "salary"
    t.string "description"
    t.bigint "employer_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["employer_id"], name: "index_vacancies_on_employer_id"
  end

  create_table "vacancy_skills", force: :cascade do |t|
    t.bigint "skill_id", null: false
    t.bigint "vacancy_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["skill_id"], name: "index_vacancy_skills_on_skill_id"
    t.index ["vacancy_id"], name: "index_vacancy_skills_on_vacancy_id"
  end

  create_table "work_experiences", force: :cascade do |t|
    t.string "job_title"
    t.text "description"
    t.string "company"
    t.string "country_of_work"
    t.string "city_or_state_of_work"
    t.boolean "i_currently_work_here"
    t.datetime "from"
    t.datetime "to"
    t.bigint "resume_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["resume_id"], name: "index_work_experiences_on_resume_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "educations", "resumes"
  add_foreign_key "employers", "users"
  add_foreign_key "job_seekers", "users"
  add_foreign_key "locations", "job_seekers"
  add_foreign_key "resume_skills", "resumes"
  add_foreign_key "resume_skills", "skills"
  add_foreign_key "resumes", "job_seekers"
  add_foreign_key "vacancies", "employers"
  add_foreign_key "vacancy_skills", "skills"
  add_foreign_key "vacancy_skills", "vacancies"
  add_foreign_key "work_experiences", "resumes"
end
