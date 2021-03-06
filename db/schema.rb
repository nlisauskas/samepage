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

ActiveRecord::Schema.define(version: 2020_03_05_125938) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "bids", force: :cascade do |t|
    t.integer "price"
    t.integer "payout"
    t.string "availability"
    t.string "notes"
    t.integer "maintenance_request_id"
    t.integer "contractor_id"
    t.boolean "approved", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "info_requested", default: false
    t.string "payment_intent"
  end

  create_table "comments", force: :cascade do |t|
    t.text "body"
    t.integer "commentable_id"
    t.string "commentable_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.integer "contractor_id"
  end

  create_table "contractors", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "company"
    t.string "email"
    t.string "password_digest"
    t.integer "maintenance_request_id"
    t.string "phone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "occupation"
    t.string "stripe_uid"
    t.string "password_reset_token"
    t.datetime "password_reset_sent_at"
  end

  create_table "maintenance_requests", force: :cascade do |t|
    t.string "category"
    t.string "description"
    t.string "title"
    t.integer "property_id"
    t.integer "tenant_id"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "resolved"
    t.integer "contractor_id"
    t.boolean "contractor_resolved", default: false
  end

  create_table "properties", force: :cascade do |t|
    t.string "street_1"
    t.string "street_2"
    t.string "city"
    t.string "state"
    t.integer "zipcode"
    t.integer "user_id"
    t.integer "tenant_id"
    t.datetime "purchase_date"
    t.datetime "sale_date"
    t.float "purchase_price"
    t.float "sale_price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tenants", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "gender"
    t.datetime "birthdate"
    t.string "password_digest"
    t.string "email"
    t.integer "property_id"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "stripe_uid"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "gender"
    t.datetime "birthdate"
    t.string "password_digest"
    t.string "email"
    t.integer "property_id"
    t.integer "tenant_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "stripe_uid"
    t.string "stripe_token"
    t.string "password_reset_token"
    t.datetime "password_reset_sent_at"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
end
