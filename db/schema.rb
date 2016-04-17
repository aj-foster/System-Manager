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

ActiveRecord::Schema.define(version: 20150205055958) do

  create_table "alerts", force: true do |t|
    t.string   "name",           default: ""
    t.string   "message",        default: ""
    t.integer  "multiplicity",   default: 1
    t.integer  "alertable_id"
    t.string   "alertable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "alerts", ["alertable_id", "alertable_type"], name: "index_alerts_on_alertable_id_and_alertable_type"

  create_table "drive_statuses", force: true do |t|
    t.integer  "drive_id"
    t.integer  "lifetime",      default: 0
    t.integer  "reallocations", default: 0
    t.integer  "pending",       default: 0
    t.integer  "uncorrectable", default: 0
    t.boolean  "healthy",       default: true
    t.integer  "ssd_wear",      default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "drive_statuses", ["drive_id"], name: "index_drive_statuses_on_drive_id"

  create_table "drives", force: true do |t|
    t.integer  "machine_id"
    t.string   "name",          default: ""
    t.string   "manufacturer",  default: ""
    t.string   "serial_number", default: ""
    t.string   "part_number",   default: ""
    t.integer  "capacity",      default: 0
    t.string   "format",        default: "HDD"
    t.string   "usage",         default: ""
    t.date     "warranty_exp"
    t.text     "notes",         default: ""
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "drives", ["machine_id"], name: "index_drives_on_machine_id"

  create_table "extended_attributes", force: true do |t|
    t.string   "model",      default: ""
    t.string   "name",       default: ""
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "machines", force: true do |t|
    t.string   "name",       default: ""
    t.string   "location",   default: ""
    t.string   "ip_address", default: ""
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "name",                   default: ""
    t.string   "role",                   default: "unapproved"
    t.boolean  "send_alerts",            default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email",                  default: "",           null: false
    t.string   "encrypted_password",     default: "",           null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,            null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
