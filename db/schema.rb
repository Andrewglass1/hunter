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

ActiveRecord::Schema.define(:version => 20120621203650) do

  create_table "deals", :force => true do |t|
    t.integer  "merchant_id"
    t.integer  "market_id"
    t.boolean  "gmaps"
    t.integer  "yipit_deal_id"
    t.date     "date_added"
    t.date     "date_ended"
    t.string   "provider"
    t.string   "full_title"
    t.string   "short_title"
    t.float    "price"
    t.float    "value"
    t.float    "discount"
    t.integer  "sold"
    t.string   "sold_out"
    t.float    "revenue"
    t.float    "revenue_index"
    t.string   "deal_url"
    t.string   "category"
    t.float    "latitude"
    t.float    "longitude"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "markets", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "merchants", :force => true do |t|
    t.string   "name"
    t.integer  "yipit_merchant_id"
    t.string   "address"
    t.string   "city"
    t.string   "zip"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "phone"
    t.string   "website"
    t.integer  "appearances"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

end
