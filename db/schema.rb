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

ActiveRecord::Schema.define(version: 20140527182017) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "comment_votes", force: true do |t|
    t.integer  "user_id",                null: false
    t.integer  "comment_id",             null: false
    t.integer  "value",      default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comment_votes", ["user_id", "comment_id"], name: "index_comment_votes_on_user_id_and_comment_id", unique: true, using: :btree

  create_table "comments", force: true do |t|
    t.string   "body",       null: false
    t.integer  "parent_id"
    t.integer  "post_id",    null: false
    t.integer  "user_id",    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "posts", force: true do |t|
    t.string   "title",                      null: false
    t.string   "url"
    t.string   "body"
    t.string   "sub",        default: "sub"
    t.integer  "user_id",                    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "username",        null: false
    t.string   "password_digest"
    t.string   "session_token"
    t.integer  "fb_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "votes", force: true do |t|
    t.integer  "user_id",                null: false
    t.integer  "post_id",                null: false
    t.integer  "value",      default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "votes", ["user_id", "post_id"], name: "index_votes_on_user_id_and_post_id", unique: true, using: :btree

end
