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

ActiveRecord::Schema.define(version: 20140524093556) do

  create_table "ckeditor_assets", force: true do |t|
    t.string   "data_file_name",               null: false
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.integer  "assetable_id"
    t.string   "assetable_type",    limit: 30
    t.string   "type",              limit: 30
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ckeditor_assets", ["assetable_type", "assetable_id"], name: "idx_ckeditor_assetable"
  add_index "ckeditor_assets", ["assetable_type", "type", "assetable_id"], name: "idx_ckeditor_assetable_type"

  create_table "contests", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "contests_problems", id: false, force: true do |t|
    t.integer "contest_id"
    t.integer "problem_id"
  end

  create_table "delayed_jobs", force: true do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority"

  create_table "problems", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "input_format"
    t.text     "output_format"
    t.text     "sample_input"
    t.text     "sample_output"
    t.text     "hint"
    t.text     "rendered_sample_input"
    t.text     "rendered_sample_output"
    t.string   "data"
    t.integer  "time_limit"
    t.integer  "memory_limit"
    t.integer  "case_num"
    t.integer  "case_score"
    t.boolean  "data_synced"
  end

  create_table "solutions", force: true do |t|
    t.integer  "problem_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title"
    t.text     "content"
  end

  add_index "solutions", ["problem_id"], name: "index_solutions_on_problem_id"

  create_table "submissions", force: true do |t|
    t.integer  "problem_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "code"
    t.string   "language"
    t.integer  "time_cost"
    t.integer  "memory_cost"
    t.string   "result"
    t.integer  "contest_id"
    t.text     "rendered_code"
    t.string   "details"
  end

  add_index "submissions", ["contest_id"], name: "index_submissions_on_contest_id"
  add_index "submissions", ["problem_id"], name: "index_submissions_on_problem_id"

end
