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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20131015155154) do

  create_table "event_moderators", :force => true do |t|
    t.integer  "event_id"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "event_registrations", :force => true do |t|
    t.integer  "event_id"
    t.integer  "user_id"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
    t.text     "note"
    t.string   "participation_level"
  end

  create_table "events", :force => true do |t|
    t.string   "title"
    t.date     "start_date"
    t.date     "end_date"
    t.date     "voting_end_date"
    t.datetime "created_at",                              :null => false
    t.datetime "updated_at",                              :null => false
    t.boolean  "voting_enabled",       :default => true
    t.boolean  "volunteering_enabled", :default => true
    t.date     "volunteer_end_date"
    t.text     "description"
    t.date     "registration_end_dt"
    t.integer  "registration_maximum"
    t.boolean  "live",                 :default => false
  end

  create_table "project_comments", :force => true do |t|
    t.integer  "project_id"
    t.integer  "user_id"
    t.string   "title"
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "project_ratings", :force => true do |t|
    t.integer  "project_id"
    t.integer  "user_id"
    t.integer  "rating"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "project_tags", :force => true do |t|
    t.integer  "project_id"
    t.string   "tag"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "project_volunteers", :force => true do |t|
    t.integer  "project_id"
    t.integer  "user_id"
    t.string   "interest_level"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "projects", :force => true do |t|
    t.integer  "event_id"
    t.integer  "project_owner_id"
    t.string   "title"
    t.text     "description"
    t.datetime "created_at",                                                         :null => false
    t.datetime "updated_at",                                                         :null => false
    t.string   "classification"
    t.boolean  "approved",         :default => false
    t.string   "repository",       :default => "http://github.umn.edu/exam/ple.git"
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "uid"
    t.string   "deptid"
    t.string   "department"
    t.string   "email"
    t.string   "image"
    t.boolean  "admin"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
