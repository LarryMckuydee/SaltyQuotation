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

ActiveRecord::Schema.define(version: 20150826033311) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

  create_table "additional_infos", force: :cascade do |t|
    t.text     "description"
    t.integer  "approval_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "quotation_id"
    t.integer  "price_cents"
    t.string   "currency"
  end

  create_table "admin_users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree

  create_table "apparel_consultants", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.integer  "approve_right"
  end

  add_index "apparel_consultants", ["email"], name: "index_apparel_consultants_on_email", unique: true, using: :btree
  add_index "apparel_consultants", ["reset_password_token"], name: "index_apparel_consultants_on_reset_password_token", unique: true, using: :btree

  create_table "audits", force: :cascade do |t|
    t.integer  "auditable_id"
    t.string   "auditable_type"
    t.integer  "associated_id"
    t.string   "associated_type"
    t.integer  "user_id"
    t.string   "user_type"
    t.string   "username"
    t.string   "action"
    t.text     "audited_changes"
    t.integer  "version",         default: 0
    t.string   "comment"
    t.string   "remote_address"
    t.string   "request_uuid"
    t.datetime "created_at"
  end

  add_index "audits", ["associated_id", "associated_type"], name: "associated_index", using: :btree
  add_index "audits", ["auditable_id", "auditable_type"], name: "auditable_index", using: :btree
  add_index "audits", ["created_at"], name: "index_audits_on_created_at", using: :btree
  add_index "audits", ["request_uuid"], name: "index_audits_on_request_uuid", using: :btree
  add_index "audits", ["user_id", "user_type"], name: "user_index", using: :btree

  create_table "block_nos", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "block_sizes", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "block_sizes_print_methods", id: false, force: :cascade do |t|
    t.integer "print_method_id", null: false
    t.integer "block_size_id",   null: false
  end

  create_table "brand_categorizations", force: :cascade do |t|
    t.integer  "brand_id"
    t.integer  "fit_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "brands", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "add_on_entitled"
  end

  create_table "brands_fits", id: false, force: :cascade do |t|
    t.integer "brand_id", null: false
    t.integer "fit_id",   null: false
  end

  create_table "brands_shirt_types", id: false, force: :cascade do |t|
    t.integer "brand_id",      null: false
    t.integer "shirt_type_id", null: false
  end

  create_table "conversion_rates", force: :cascade do |t|
    t.integer  "exchange_rate_cents"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  create_table "costings", force: :cascade do |t|
    t.integer  "price"
    t.integer  "cost"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "customers", force: :cascade do |t|
    t.string   "full_name"
    t.string   "contact"
    t.string   "address_line1"
    t.string   "address_line2"
    t.string   "address_line3"
    t.string   "city"
    t.string   "postal"
    t.string   "state"
    t.string   "country"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.integer  "existing_customer"
  end

  create_table "designs", force: :cascade do |t|
    t.string   "file_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "fits", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "negotiations", force: :cascade do |t|
    t.integer  "min_rrp"
    t.integer  "max_rrp"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "print_method_block_size_relations", force: :cascade do |t|
    t.integer  "print_method_id"
    t.integer  "block_size_id"
    t.integer  "price_cents"
    t.integer  "block_charge_price_cents"
    t.integer  "start_quantity"
    t.integer  "end_quantity"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.integer  "is_primary"
  end

  create_table "print_methods", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "printing_details", force: :cascade do |t|
    t.integer  "front_print_id"
    t.integer  "back_print_id"
    t.integer  "left_print_id"
    t.integer  "right_print_id"
    t.integer  "special"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "prints", force: :cascade do |t|
    t.integer  "method_id"
    t.integer  "size_id"
    t.integer  "block_no"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "quotations", force: :cascade do |t|
    t.integer  "delivered"
    t.datetime "deadline"
    t.integer  "ac_id"
    t.integer  "customer_id"
    t.integer  "approval_id"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "shirt_type_id"
    t.integer  "brand_id"
    t.integer  "fit_id"
    t.integer  "front_print_method_id"
    t.integer  "front_block_size_id"
    t.integer  "back_print_method_id"
    t.integer  "back_block_size_id"
    t.integer  "left_print_method_id"
    t.integer  "right_print_method_id"
    t.integer  "special_print"
    t.integer  "front_block_no"
    t.integer  "back_block_no"
    t.integer  "left_block_no"
    t.integer  "right_block_no"
    t.integer  "quantity"
    t.string   "design_file_name"
    t.integer  "budget_cents"
    t.integer  "rush_fee_cents"
    t.integer  "delivery_fee_cents"
    t.integer  "price_cents"
    t.integer  "cost_cents"
    t.integer  "min_rrp_cents"
    t.integer  "max_rrp_cents"
    t.integer  "actual_price_cents"
    t.integer  "total_cost_cents"
    t.integer  "sew_tag_charge_cents"
    t.integer  "woven_tag_quantity"
    t.integer  "woven_tag_charge_cents"
    t.integer  "relabel_quantity"
    t.integer  "relabel_charge_cents"
    t.integer  "exchange_rate_cents"
    t.string   "currency"
  end

  create_table "relabels", force: :cascade do |t|
    t.integer  "relabel_charge_cents"
    t.integer  "start_quantity"
    t.integer  "end_quantity"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  create_table "shirt_type_fit_relations", force: :cascade do |t|
    t.integer  "shirt_type_id"
    t.integer  "fit_id"
    t.integer  "price_cents"
    t.integer  "start_quantity"
    t.integer  "end_quantity"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "shirt_types", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "shirts", force: :cascade do |t|
    t.integer  "brand_id"
    t.integer  "type_id"
    t.integer  "fit_id"
    t.integer  "quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "woven_tags", force: :cascade do |t|
    t.integer  "tag_charge_cents"
    t.integer  "start_quantity"
    t.integer  "end_quantity"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

end
