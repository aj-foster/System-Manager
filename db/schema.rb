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

ActiveRecord::Schema.define(version: 20141221032558) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "hstore"

  create_table "alerts", force: true do |t|
    t.string   "name"
    t.string   "message"
    t.integer  "multiplicity"
    t.integer  "alertable_id"
    t.string   "alertable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "alerts", ["alertable_id", "alertable_type"], name: "index_alerts_on_alertable_id_and_alertable_type", using: :btree

  create_table "disk_statuses", force: true do |t|
    t.integer  "disk_id"
    t.integer  "lifetime"
    t.integer  "reallocations"
    t.integer  "pending"
    t.integer  "uncorrectable"
    t.boolean  "healthy"
    t.integer  "ssd_wear"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "disk_statuses", ["disk_id"], name: "index_disk_statuses_on_disk_id", using: :btree

  create_table "disks", force: true do |t|
    t.integer  "machine_id"
    t.string   "name"
    t.string   "manufacturer"
    t.string   "serial_number"
    t.string   "part_number"
    t.integer  "capacity"
    t.string   "type"
    t.string   "usage"
    t.date     "warranty_exp"
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "disks", ["machine_id"], name: "index_disks_on_machine_id", using: :btree

  create_table "machines", force: true do |t|
    t.string   "name"
    t.string   "location"
    t.string   "ip_address"
    t.hstore   "info"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
