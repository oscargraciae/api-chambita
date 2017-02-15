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

ActiveRecord::Schema.define(version: 20170215002215) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "api_logs", force: :cascade do |t|
    t.string   "message"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "module"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name", null: false
  end

  create_table "credit_cards", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "token"
    t.string   "last4"
    t.string   "brand"
    t.boolean  "active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "credit_cards", ["user_id"], name: "index_credit_cards_on_user_id", using: :btree

  create_table "evaluations", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "service_id"
    t.string   "comment"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "supplier_id"
    t.integer  "subcategory_id"
  end

  add_index "evaluations", ["service_id"], name: "index_evaluations_on_service_id", using: :btree
  add_index "evaluations", ["user_id"], name: "index_evaluations_on_user_id", using: :btree

  create_table "identities", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "provider"
    t.string   "uid"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "identities", ["user_id"], name: "index_identities_on_user_id", using: :btree

  create_table "inbox_messages", force: :cascade do |t|
    t.string   "message"
    t.integer  "sender_user"
    t.integer  "inbox_id"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.boolean  "readit",      default: false
  end

  add_index "inbox_messages", ["inbox_id"], name: "index_inbox_messages_on_inbox_id", using: :btree

  create_table "inboxes", force: :cascade do |t|
    t.integer  "sender_id"
    t.integer  "recipient_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "locations", force: :cascade do |t|
    t.string   "location"
    t.decimal  "geo_lat",             precision: 9, scale: 6
    t.decimal  "geo_lng",             precision: 9, scale: 6
    t.string   "route"
    t.string   "locality"
    t.string   "administrative_area"
    t.string   "country"
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
  end

  create_table "log_apis", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "notifications", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "notified_by_id"
    t.integer  "request_service_id"
    t.integer  "identifier"
    t.string   "type_notification"
    t.boolean  "read"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  add_index "notifications", ["notified_by_id"], name: "index_notifications_on_notified_by_id", using: :btree
  add_index "notifications", ["request_service_id"], name: "index_notifications_on_request_service_id", using: :btree
  add_index "notifications", ["user_id"], name: "index_notifications_on_user_id", using: :btree

  create_table "order_statuses", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "orders", force: :cascade do |t|
    t.integer  "request_service_id"
    t.integer  "order_status_id"
    t.decimal  "service_price"
    t.decimal  "fee"
    t.decimal  "total"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  add_index "orders", ["order_status_id"], name: "index_orders_on_order_status_id", using: :btree
  add_index "orders", ["request_service_id"], name: "index_orders_on_request_service_id", using: :btree

  create_table "packages", force: :cascade do |t|
    t.string   "title"
    t.string   "description"
    t.decimal  "price"
    t.integer  "unit_type_id"
    t.integer  "unit_max"
    t.integer  "service_id"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.boolean  "is_principal", default: false
    t.boolean  "active",       default: true
  end

  add_index "packages", ["service_id"], name: "index_packages_on_service_id", using: :btree

  create_table "rating_types", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "ratings", force: :cascade do |t|
    t.integer  "rating_type_id"
    t.integer  "value"
    t.integer  "evaluation_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "ratings", ["evaluation_id"], name: "index_ratings_on_evaluation_id", using: :btree
  add_index "ratings", ["rating_type_id"], name: "index_ratings_on_rating_type_id", using: :btree

  create_table "request_messages", force: :cascade do |t|
    t.text     "text"
    t.integer  "sender_id"
    t.integer  "recipient_id"
    t.integer  "request_service_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  add_index "request_messages", ["request_service_id"], name: "index_request_messages_on_request_service_id", using: :btree

  create_table "request_services", force: :cascade do |t|
    t.text     "message"
    t.date     "request_date"
    t.time     "request_time"
    t.integer  "request_status_id",                          default: 1
    t.integer  "service_id"
    t.integer  "user_id"
    t.datetime "created_at",                                                 null: false
    t.datetime "updated_at",                                                 null: false
    t.decimal  "price"
    t.decimal  "fee"
    t.integer  "supplier_id"
    t.boolean  "is_finish_supplier",                         default: false
    t.boolean  "is_finish_customer",                         default: false
    t.boolean  "is_evaluated",                               default: false
    t.decimal  "total"
    t.string   "token_card"
    t.decimal  "subtotal",           precision: 8, scale: 2
    t.integer  "quantity",                                   default: 1
    t.integer  "package_id"
  end

  add_index "request_services", ["package_id"], name: "index_request_services_on_package_id", using: :btree
  add_index "request_services", ["request_status_id"], name: "index_request_services_on_request_status_id", using: :btree
  add_index "request_services", ["service_id"], name: "index_request_services_on_service_id", using: :btree
  add_index "request_services", ["user_id"], name: "index_request_services_on_user_id", using: :btree

  create_table "request_statuses", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "service_images", force: :cascade do |t|
    t.string   "caption"
    t.integer  "service_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.text     "photo"
  end

  add_index "service_images", ["service_id"], name: "index_service_images_on_service_id", using: :btree

  create_table "services", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "category_id"
    t.decimal  "price",              precision: 8, scale: 2
    t.boolean  "is_fixed_price"
    t.datetime "created_at",                                                null: false
    t.datetime "updated_at",                                                null: false
    t.integer  "user_id"
    t.integer  "sub_category_id"
    t.boolean  "published"
    t.string   "cover_file_name"
    t.string   "cover_content_type"
    t.integer  "cover_file_size"
    t.datetime "cover_updated_at"
    t.decimal  "rating_general",     precision: 8, scale: 1, default: 0.0
    t.integer  "total_jobs",                                 default: 0
    t.boolean  "isActive",                                   default: true
    t.integer  "unit_type_id"
    t.integer  "unit_max"
    t.integer  "visits",                                     default: 0
  end

  add_index "services", ["unit_type_id"], name: "index_services_on_unit_type_id", using: :btree
  add_index "services", ["user_id"], name: "index_services_on_user_id", using: :btree

  create_table "sub_categories", force: :cascade do |t|
    t.string   "name"
    t.integer  "category_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "sub_categories", ["category_id"], name: "index_sub_categories_on_category_id", using: :btree

  create_table "table_categories", force: :cascade do |t|
    t.string "name", null: false
  end

  create_table "tests", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "unit_types", force: :cascade do |t|
    t.string   "description"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.string   "singular_name"
  end

  create_table "users", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "password"
    t.datetime "birthdate"
    t.string   "cellphone"
    t.text     "description"
    t.text     "avatar"
    t.text     "token"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.integer  "location_id"
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.float    "lat"
    t.float    "lng"
    t.string   "country"
    t.string   "state"
    t.string   "city"
    t.string   "address_street"
    t.string   "address_area"
    t.string   "address_zipcode"
    t.string   "conektaid"
    t.string   "facebook_id"
    t.boolean  "IsActiveEmail",          default: false
    t.string   "address"
    t.string   "clabe"
    t.string   "bank"
    t.boolean  "is_completed",           default: false
    t.string   "username"
    t.boolean  "is_supplier",            default: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["location_id"], name: "index_users_on_location_id", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "credit_cards", "users"
  add_foreign_key "evaluations", "services"
  add_foreign_key "evaluations", "users"
  add_foreign_key "identities", "users"
  add_foreign_key "inbox_messages", "inboxes"
  add_foreign_key "notifications", "request_services"
  add_foreign_key "notifications", "users"
  add_foreign_key "notifications", "users", column: "notified_by_id"
  add_foreign_key "orders", "order_statuses"
  add_foreign_key "orders", "request_services"
  add_foreign_key "packages", "services"
  add_foreign_key "ratings", "evaluations"
  add_foreign_key "ratings", "rating_types"
  add_foreign_key "request_messages", "request_services"
  add_foreign_key "request_services", "packages"
  add_foreign_key "request_services", "request_statuses"
  add_foreign_key "request_services", "services"
  add_foreign_key "request_services", "users"
  add_foreign_key "service_images", "services"
  add_foreign_key "services", "unit_types"
  add_foreign_key "services", "users"
  add_foreign_key "sub_categories", "categories"
  add_foreign_key "users", "locations"
end
