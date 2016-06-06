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

ActiveRecord::Schema.define(version: 20160603202433) do

  create_table "queries", force: :cascade do |t|
    t.string   "query",      limit: 255
    t.text     "concat",     limit: 65535
    t.string   "userid",     limit: 255
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "reports", force: :cascade do |t|
    t.integer  "qid",        limit: 4
    t.datetime "pub_date"
    t.text     "url",        limit: 65535
    t.text     "clean_text", limit: 65535
    t.float    "score",      limit: 24
    t.string   "source",     limit: 255
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "results", force: :cascade do |t|
    t.string   "ticker",     limit: 255
    t.string   "company",    limit: 255
    t.datetime "date"
    t.text     "url",        limit: 65535
    t.string   "senttype",   limit: 255
    t.float    "score",      limit: 24
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.text     "urltext",    limit: 65535
  end

end
