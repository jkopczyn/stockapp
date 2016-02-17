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

ActiveRecord::Schema.define(version: 20160217094118) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "stocks", force: :cascade do |t|
    t.string   "ticker_symbol",                             null: false
    t.integer  "last_known_price_cents",    default: 0,     null: false
    t.string   "last_known_price_currency", default: "USD", null: false
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
  end

  add_index "stocks", ["ticker_symbol"], name: "index_stocks_on_ticker_symbol", unique: true, using: :btree

# Could not dump table "transactions" because of following StandardError
#   Unknown type 'transaction_type' for column 'type'

  create_table "users", force: :cascade do |t|
    t.string   "password_digest"
    t.string   "email",                            null: false
    t.string   "session_token",                    null: false
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.integer  "balance_cents",    default: 0,     null: false
    t.string   "balance_currency", default: "USD", null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["session_token"], name: "index_users_on_session_token", unique: true, using: :btree

  add_foreign_key "transactions", "stocks"
  add_foreign_key "transactions", "users"
end
