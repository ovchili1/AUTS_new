# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_03_09_090747) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "answers", force: :cascade do |t|
    t.string "ans_body"
    t.boolean "right"
    t.float "weight"
    t.bigint "question_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["question_id"], name: "index_answers_on_question_id"
  end

  create_table "assem_answers", force: :cascade do |t|
    t.string "ans_body"
    t.boolean "right"
    t.float "weight"
    t.bigint "assem_question_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["assem_question_id"], name: "index_assem_answers_on_assem_question_id"
  end

  create_table "assem_options", force: :cascade do |t|
    t.string "ans_body"
    t.boolean "right"
    t.float "weight"
    t.bigint "assem_question_id", null: false
    t.integer "student_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["assem_question_id"], name: "index_assem_options_on_assem_question_id"
  end

  create_table "assem_questions", force: :cascade do |t|
    t.text "quest_body"
    t.boolean "right"
    t.bigint "testing_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["testing_id"], name: "index_assem_questions_on_testing_id"
  end

  create_table "questions", force: :cascade do |t|
    t.text "quest_body"
    t.bigint "thema_id", null: false
    t.integer "teacher_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "quest_type"
    t.index ["thema_id"], name: "index_questions_on_thema_id"
  end

  create_table "test_themas", force: :cascade do |t|
    t.bigint "thema_id", null: false
    t.bigint "test_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["test_id"], name: "index_test_themas_on_test_id"
    t.index ["thema_id"], name: "index_test_themas_on_thema_id"
  end

  create_table "testings", force: :cascade do |t|
    t.integer "num_of_right_options"
    t.integer "student_id"
    t.bigint "test_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "percent_Right"
    t.integer "num_of_quest"
    t.index ["test_id"], name: "index_testings_on_test_id"
  end

  create_table "tests", force: :cascade do |t|
    t.string "name"
    t.integer "teacher_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "num_of_quest"
  end

  create_table "themas", force: :cascade do |t|
    t.string "name"
    t.integer "teacher_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "login"
    t.string "email"
    t.string "password_digest"
    t.string "type", default: "Student"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "answers", "questions"
  add_foreign_key "assem_answers", "assem_questions"
  add_foreign_key "assem_options", "assem_questions"
  add_foreign_key "assem_questions", "testings"
  add_foreign_key "questions", "themas"
  add_foreign_key "test_themas", "tests"
  add_foreign_key "test_themas", "themas"
  add_foreign_key "testings", "tests"
end
