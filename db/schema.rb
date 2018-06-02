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

ActiveRecord::Schema.define(version: 2018_05_27_154614) do

  create_table "categories", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "name"
    t.string "code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "farm_equips", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.integer "maker_price"
    t.integer "used_price"
    t.string "maker"
    t.string "model"
    t.string "horse_power"
    t.string "josu"
    t.integer "model_year"
    t.string "drive_system"
    t.string "safety_frame"
    t.string "rotary"
    t.string "hour_meter"
    t.string "accessories"
    t.string "location"
    t.string "condition"
    t.string "category_code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_code"], name: "index_farm_equips_on_category_code"
    t.index ["maker"], name: "index_farm_equips_on_maker"
  end

end