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

ActiveRecord::Schema.define(version: 20131218182709) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "graphs", force: true do |t|
    t.string   "name"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "data"
    t.json     "graph_json"
  end

  add_index "graphs", ["user_id"], name: "index_graphs_on_user_id", using: :btree

  create_table "links", force: true do |t|
    t.integer  "value"
    t.boolean  "checked",    default: true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "graph_id"
    t.integer  "source"
    t.integer  "target"
    t.integer  "node_id"
  end

  add_index "links", ["graph_id"], name: "index_links_on_graph_id", using: :btree

  create_table "nodes", force: true do |t|
    t.string   "name"
    t.integer  "group"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "file_path"
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "salt"
    t.string   "hashed_password"
  end

end
