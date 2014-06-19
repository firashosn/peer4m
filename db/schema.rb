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

ActiveRecord::Schema.define(version: 20140617012019) do

  create_table "articles", force: true do |t|
    t.string   "title"
    t.text     "text"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "assignments", force: true do |t|
    t.string   "name"
    t.datetime "open_time"
    t.datetime "close_time"
    t.text     "instructions"
    t.integer  "course_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "assignments", ["course_id"], name: "index_assignments_on_course_id"

  create_table "courses", force: true do |t|
    t.string   "course_id"
    t.string   "course_name"
    t.integer  "instructor_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "courses", ["instructor_id"], name: "index_courses_on_instructor_id"

  create_table "instructors", force: true do |t|
    t.string   "user_name"
    t.string   "password"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "students", force: true do |t|
    t.string   "user_name"
    t.string   "password"
    t.string   "first_name"
    t.string   "last_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "teams", force: true do |t|
    t.integer  "name"
    t.integer  "assignment_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "teams", ["assignment_id"], name: "index_teams_on_assignment_id"

end
