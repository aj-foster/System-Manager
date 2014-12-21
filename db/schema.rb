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

ActiveRecord::Schema.define(version: 20141221020753) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "hstore"

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
