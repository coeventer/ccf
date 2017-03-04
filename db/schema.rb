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

ActiveRecord::Schema.define(version: 20170228213605) do

  create_table "event_comments", force: :cascade do |t|
    t.integer  "event_id",    limit: 4
    t.integer  "user_id",     limit: 4
    t.text     "description", limit: 65535
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "event_moderators", force: :cascade do |t|
    t.integer  "event_id",   limit: 4
    t.integer  "user_id",    limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  create_table "event_registrations", force: :cascade do |t|
    t.integer  "event_id",            limit: 4
    t.integer  "user_id",             limit: 4
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.text     "note",                limit: 65535
    t.string   "participation_level", limit: 255
    t.string   "name",                limit: 255
  end

  create_table "events", force: :cascade do |t|
    t.string   "title",                limit: 255
    t.datetime "start_date"
    t.datetime "end_date"
    t.datetime "voting_end_date"
    t.datetime "created_at",                                         null: false
    t.datetime "updated_at",                                         null: false
    t.boolean  "voting_enabled",                     default: true
    t.boolean  "volunteering_enabled",               default: true
    t.datetime "volunteer_end_date"
    t.text     "description",          limit: 65535
    t.datetime "registration_end_dt"
    t.integer  "registration_maximum", limit: 4
    t.boolean  "live",                               default: false
    t.text     "schedule",             limit: 65535
    t.text     "other_info",           limit: 65535
    t.integer  "organization_id",      limit: 4,     default: 0
    t.boolean  "dashboard_enabled",                  default: true
    t.string   "event_logo",           limit: 255
    t.text     "customizations",       limit: 65535
    t.integer  "flags",                limit: 4,     default: 0,     null: false
  end

  create_table "invitations", force: :cascade do |t|
    t.string   "email",           limit: 255
    t.string   "token",           limit: 255
    t.integer  "organization_id", limit: 4
    t.string   "context_type",    limit: 255
    t.integer  "context_id",      limit: 4
    t.integer  "user_id",         limit: 4
    t.string   "status",          limit: 255, default: "pending"
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
  end

  create_table "organization_users", force: :cascade do |t|
    t.integer  "organization_id", limit: 4
    t.integer  "user_id",         limit: 4
    t.boolean  "verified"
    t.boolean  "admin"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "organizations", force: :cascade do |t|
    t.string   "name",                limit: 255
    t.string   "subdomain",           limit: 255
    t.string   "auto_verify_domains", limit: 255
    t.boolean  "auto_verify"
    t.string   "description",         limit: 255
    t.string   "website",             limit: 255
    t.datetime "created_at",                                                             null: false
    t.datetime "updated_at",                                                             null: false
    t.string   "organization_logo",   limit: 255
    t.string   "slack_webhook_url",   limit: 255
    t.boolean  "public_access",                   default: false
    t.string   "time_zone",           limit: 255, default: "Central Time (US & Canada)"
  end

  create_table "presentations", force: :cascade do |t|
    t.text     "why",        limit: 65535
    t.text     "what",       limit: 65535
    t.text     "right",      limit: 65535
    t.text     "wrong",      limit: 65535
    t.text     "next_steps", limit: 65535
    t.integer  "project_id", limit: 4
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.boolean  "published"
    t.string   "title",      limit: 255
  end

  create_table "project_comments", force: :cascade do |t|
    t.integer  "project_id",  limit: 4
    t.integer  "user_id",     limit: 4
    t.string   "title",       limit: 255
    t.text     "description", limit: 65535
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "project_ratings", force: :cascade do |t|
    t.integer  "project_id", limit: 4
    t.integer  "user_id",    limit: 4
    t.integer  "rating",     limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  create_table "project_tags", force: :cascade do |t|
    t.integer  "project_id", limit: 4
    t.string   "tag",        limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "project_volunteers", force: :cascade do |t|
    t.integer  "project_id",     limit: 4
    t.integer  "user_id",        limit: 4
    t.string   "interest_level", limit: 255
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  create_table "projects", force: :cascade do |t|
    t.integer  "event_id",                 limit: 4
    t.integer  "project_owner_id",         limit: 4
    t.string   "title",                    limit: 255
    t.text     "description",              limit: 65535
    t.datetime "created_at",                                             null: false
    t.datetime "updated_at",                                             null: false
    t.string   "classification",           limit: 255
    t.boolean  "approved",                               default: false
    t.string   "repository",               limit: 255
    t.integer  "project_comments_count",   limit: 4,     default: 0
    t.integer  "project_ratings_count",    limit: 4,     default: 0
    t.integer  "project_volunteers_count", limit: 4,     default: 0
    t.integer  "organization_id",          limit: 4,     default: 0
    t.integer  "submitted_user_id",        limit: 4
    t.float    "hotness",                  limit: 24
  end

  create_table "provider_users", force: :cascade do |t|
    t.string   "uid",        limit: 255
    t.string   "provider",   limit: 255
    t.integer  "user_id",    limit: 4
    t.string   "token",      limit: 255
    t.boolean  "validated",              default: false
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "name",                     limit: 255
    t.string   "uid",                      limit: 255
    t.string   "deptid",                   limit: 255
    t.string   "department",               limit: 255
    t.string   "email",                    limit: 255
    t.string   "image",                    limit: 255
    t.boolean  "admin"
    t.datetime "created_at",                                           null: false
    t.datetime "updated_at",                                           null: false
    t.boolean  "verified"
    t.boolean  "send_notifications",                   default: true
    t.boolean  "email_confirmed",                      default: false
    t.string   "email_confirmation_token", limit: 255
  end

end
