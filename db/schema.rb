# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_10_13_131144) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "checkout_products", force: :cascade do |t|
    t.datetime "removed_at"
    t.bigint "product_id", null: false
    t.bigint "checkout_session_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["checkout_session_id"], name: "index_checkout_products_on_checkout_session_id"
    t.index ["product_id"], name: "index_checkout_products_on_product_id"
  end

  create_table "checkout_sessions", force: :cascade do |t|
    t.string "token"
    t.datetime "ended_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "products", force: :cascade do |t|
    t.string "label"
    t.float "price"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "checkout_products", "checkout_sessions"
  add_foreign_key "checkout_products", "products"
end
