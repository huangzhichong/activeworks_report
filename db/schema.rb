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

ActiveRecord::Schema.define(version: 20160215031553) do

  create_table "projects", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "sprints", force: :cascade do |t|
    t.string   "name",          limit: 255
    t.integer  "project_id",    limit: 4
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.date     "start_date"
    t.date     "end_date"
    t.string   "jira_issue_id", limit: 255
  end

  create_table "task_types", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "tasks", force: :cascade do |t|
    t.string   "summary",             limit: 255
    t.string   "assignee",            limit: 255
    t.string   "jira_ticket",         limit: 255
    t.string   "status",              limit: 255
    t.integer  "estimated_time",      limit: 4
    t.integer  "spent_time",          limit: 4
    t.integer  "number_of_test_case", limit: 4
    t.integer  "task_type_id",        limit: 4
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.integer  "sprint_id",           limit: 4
  end

end
