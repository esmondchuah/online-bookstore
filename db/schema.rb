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

ActiveRecord::Schema.define(version: 20161201182536) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "books", force: :cascade do |t|
    t.string   "isbn",          default: "", null: false
    t.string   "title"
    t.string   "authors"
    t.string   "publisher"
    t.integer  "year"
    t.integer  "inventory"
    t.decimal  "price"
    t.string   "format"
    t.string   "keywords"
    t.string   "subject"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.decimal  "average_score"
    t.index ["isbn"], name: "index_books_on_isbn", unique: true, using: :btree
  end

  create_table "carts", force: :cascade do |t|
    t.integer  "quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id"
    t.integer  "book_id"
    t.index ["book_id"], name: "index_carts_on_book_id", using: :btree
    t.index ["user_id"], name: "index_carts_on_user_id", using: :btree
  end

  create_table "manifests", id: false, force: :cascade do |t|
    t.integer "quantity"
    t.integer "order_id"
    t.integer "book_id"
    t.index ["book_id"], name: "index_manifests_on_book_id", using: :btree
    t.index ["order_id"], name: "index_manifests_on_order_id", using: :btree
  end

  create_table "opinions", force: :cascade do |t|
    t.integer  "score"
    t.text     "comment"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.integer  "user_id"
    t.integer  "book_id"
    t.decimal  "average_usefulness"
    t.index ["book_id"], name: "index_opinions_on_book_id", using: :btree
    t.index ["user_id"], name: "index_opinions_on_user_id", using: :btree
  end

  create_table "orders", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id"
    t.integer  "status"
    t.index ["user_id"], name: "index_orders_on_user_id", using: :btree
  end

  create_table "ratings", force: :cascade do |t|
    t.integer  "usefulness"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id"
    t.integer  "opinion_id"
    t.index ["opinion_id"], name: "index_ratings_on_opinion_id", using: :btree
    t.index ["user_id"], name: "index_ratings_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "username",               default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "full_name"
    t.string   "credit_card_number"
    t.string   "address"
    t.string   "phone_number"
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.boolean  "admin",                  default: false
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
    t.index ["username"], name: "index_users_on_username", unique: true, using: :btree
  end

  add_foreign_key "carts", "books", on_delete: :cascade
  add_foreign_key "carts", "users", on_delete: :cascade
  add_foreign_key "manifests", "books", on_delete: :cascade
  add_foreign_key "manifests", "orders", on_delete: :cascade
  add_foreign_key "opinions", "books", on_delete: :cascade
  add_foreign_key "opinions", "users", on_delete: :cascade
  add_foreign_key "orders", "users", on_delete: :cascade
  add_foreign_key "ratings", "opinions", on_delete: :cascade
  add_foreign_key "ratings", "users", on_delete: :cascade
end
