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

ActiveRecord::Schema.define(version: 20170304163534) do

  create_table "accounts", force: :cascade do |t|
    t.string   "email",            null: false
    t.string   "crypted_password"
    t.string   "salt"
    t.string   "phone"
    t.string   "name"
    t.string   "secondary_name"
    t.string   "secondary_phone"
    t.string   "secondary_email"
    t.string   "emergency_name"
    t.string   "emergency_phone"
    t.string   "patient_name"
    t.string   "patient_number"
    t.string   "patient_address"
    t.text     "patient_notes"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.index ["email"], name: "index_accounts_on_email", unique: true
  end

  create_table "messages", force: :cascade do |t|
    t.text     "body"
    t.string   "to_number"
    t.string   "from_number"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "schedules", force: :cascade do |t|
    t.text     "template"
    t.integer  "message_id"
    t.integer  "account_id"
    t.datetime "schedule_time"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

end
