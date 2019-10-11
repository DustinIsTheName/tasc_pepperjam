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

ActiveRecord::Schema.define(version: 20191011173313) do

  create_table "collections", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "orders", force: :cascade do |t|
    t.string   "program_id"
    t.string   "order_id"
    t.string   "item_id"
    t.integer  "item_price"
    t.integer  "quantity"
    t.string   "coupon"
    t.boolean  "uploaded"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "products", force: :cascade do |t|
    t.integer  "shopify_id",          limit: 8
    t.string   "title"
    t.text     "description"
    t.string   "vendor"
    t.text     "tags"
    t.string   "shopify_type"
    t.text     "options"
    t.string   "featured_image"
    t.string   "title_tag"
    t.text     "description_tag"
    t.string   "google_product_type"
    t.string   "age_group"
    t.string   "custom_label_0"
    t.string   "custom_label_1"
    t.string   "custom_label_2"
    t.string   "custom_label_3"
    t.string   "custom_label_4"
    t.integer  "collection_id"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.text     "variants"
  end

  add_index "products", ["shopify_id"], name: "index_products_on_shopify_id", unique: true

  create_table "shops", force: :cascade do |t|
    t.string   "name"
    t.string   "url"
    t.string   "currency"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "variants", force: :cascade do |t|
    t.integer  "shopify_id",  limit: 8
    t.string   "url"
    t.text     "options"
    t.string   "price"
    t.boolean  "available"
    t.string   "image_src"
    t.string   "barcode"
    t.string   "sku"
    t.string   "weight"
    t.string   "weight_unit"
    t.integer  "product_id"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  add_index "variants", ["shopify_id"], name: "index_variants_on_shopify_id", unique: true

end
