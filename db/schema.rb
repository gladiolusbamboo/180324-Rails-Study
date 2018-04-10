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

ActiveRecord::Schema.define(version: 20180410052604) do

  create_table "artists", force: :cascade do |t|
    t.integer "listener_id"
    t.string "name"
    t.date "birth"
    t.text "url"
    t.string "ctype"
    t.binary "photo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["listener_id"], name: "index_artists_on_listener_id"
  end

  create_table "artists_cds", id: false, force: :cascade do |t|
    t.integer "artist_id", null: false
    t.integer "cd_id", null: false
  end

  create_table "cds", force: :cascade do |t|
    t.string "jan"
    t.string "title"
    t.integer "price"
    t.string "label"
    t.date "released"
    t.boolean "is_major"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "fan_comments", force: :cascade do |t|
    t.integer "artist_no"
    t.string "name"
    t.text "body"
    t.boolean "deleted"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "listeners", force: :cascade do |t|
    t.string "listenername"
    t.string "password_digest"
    t.string "email"
    t.boolean "is_male"
    t.string "roles"
    t.integer "reviews_count"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "members", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.integer "lock_version", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "memos", force: :cascade do |t|
    t.string "memoable_type"
    t.integer "memoable_id"
    t.string "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["memoable_type", "memoable_id"], name: "index_memos_on_memoable_type_and_memoable_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.integer "cd_id"
    t.integer "listener_id"
    t.integer "status"
    t.text "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cd_id"], name: "index_reviews_on_cd_id"
    t.index ["listener_id"], name: "index_reviews_on_listener_id"
  end

end
