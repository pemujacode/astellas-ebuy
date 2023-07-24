# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_04_25_035605) do

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

  create_table "authorizations", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "costcenter"
    t.string "currency"
    t.string "department"
    t.string "expense"
    t.string "supplier"
    t.string "p_request"
    t.string "p_order"
    t.string "p_grn"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_authorizations_on_user_id"
  end

  create_table "costcenters", force: :cascade do |t|
    t.string "code"
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "currencies", force: :cascade do |t|
    t.string "code"
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "departments", force: :cascade do |t|
    t.string "name"
    t.bigint "costcenter_id"
    t.bigint "expense_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["costcenter_id"], name: "index_departments_on_costcenter_id"
    t.index ["expense_id"], name: "index_departments_on_expense_id"
  end

  create_table "depts", force: :cascade do |t|
    t.string "code"
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "expenses", force: :cascade do |t|
    t.string "code"
    t.string "name"
    t.string "gl_account"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "costcenter"
  end

  create_table "notifications", force: :cascade do |t|
    t.string "doc_type"
    t.string "doc_num"
    t.string "email"
    t.string "remaks"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "po_approvals", force: :cascade do |t|
    t.string "requester"
    t.string "apv1"
    t.decimal "apv1_amount"
    t.string "apv2"
    t.decimal "apv2_amount"
    t.string "apv3"
    t.decimal "apv3_amount"
    t.boolean "is_active"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "pr_approvals", force: :cascade do |t|
    t.string "requester"
    t.string "apv1"
    t.decimal "apv1_amount"
    t.string "apv2"
    t.decimal "apv2_amount"
    t.string "apv3"
    t.decimal "apv3_amount"
    t.string "apv4"
    t.decimal "apv4_amount"
    t.boolean "is_active"
    t.string "pic"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "trans"
    t.string "approval_group"
  end

  create_table "products", force: :cascade do |t|
    t.string "code"
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "purchase_order_items", force: :cascade do |t|
    t.bigint "purchase_order_id", null: false
    t.string "no"
    t.string "product"
    t.string "spesification"
    t.string "costcenter"
    t.decimal "price"
    t.decimal "quantity"
    t.decimal "amount"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "dept"
    t.string "description"
    t.string "item"
    t.string "status"
    t.index ["purchase_order_id"], name: "index_purchase_order_items_on_purchase_order_id"
  end

  create_table "purchase_orders", force: :cascade do |t|
    t.string "no"
    t.date "po_date"
    t.date "delivery_date"
    t.string "buyer"
    t.string "terms_payment"
    t.string "status"
    t.string "prepared_by"
    t.string "reviewed_by"
    t.string "approved_by"
    t.string "currency"
    t.decimal "total"
    t.decimal "vat"
    t.decimal "grand_total"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "remarks"
    t.datetime "rls_date"
    t.datetime "apv_date"
    t.datetime "review_date"
    t.string "supplier"
    t.string "attn"
    t.integer "user_id"
    t.string "account"
    t.string "req_email"
    t.string "department"
    t.boolean "is_vat"
    t.string "address"
    t.string "pic"
    t.decimal "disc"
    t.decimal "totbefdisc"
    t.string "doctype"
    t.string "sapno"
    t.decimal "dp"
    t.decimal "net_payment"
  end

  create_table "purchase_request_items", force: :cascade do |t|
    t.bigint "purchase_request_id", null: false
    t.string "no"
    t.string "product"
    t.decimal "quantity"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "costcenter"
    t.string "description"
    t.string "remarks"
    t.string "dept"
    t.string "spesification"
    t.index ["purchase_request_id"], name: "index_purchase_request_items_on_purchase_request_id"
  end

  create_table "purchase_requests", force: :cascade do |t|
    t.string "no"
    t.integer "user_id"
    t.string "requester"
    t.string "department"
    t.string "account"
    t.date "request_date"
    t.date "required_date"
    t.string "notes"
    t.boolean "is_newgoods"
    t.boolean "is_reorder"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "status"
    t.string "req_email"
    t.string "approval1"
    t.string "approval2"
    t.string "approval3"
    t.string "approval4"
    t.datetime "apv_date1"
    t.datetime "apv_date2"
    t.datetime "apv_date3"
    t.datetime "apv_date4"
    t.string "allocation"
    t.string "supplier"
    t.string "costcenter"
    t.string "item"
    t.decimal "quantity"
    t.decimal "price"
    t.string "supplier_reason"
    t.string "purpose"
    t.string "detail"
    t.integer "no_approval"
    t.string "apv_remarks"
    t.string "pic"
    t.string "approval_group"
  end

  create_table "suppliers", force: :cascade do |t|
    t.string "code"
    t.string "name"
    t.string "printing_name"
    t.string "address"
    t.string "npwp"
    t.string "phone"
    t.string "email"
    t.string "pic"
    t.string "currency"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "vat"
    t.boolean "is_active"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer "invitation_limit"
    t.string "invited_by_type"
    t.bigint "invited_by_id"
    t.integer "invitations_count", default: 0
    t.string "name"
    t.integer "role"
    t.string "emp_id"
    t.string "title"
    t.string "grade"
    t.bigint "department_id"
    t.boolean "is_active"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["department_id"], name: "index_users_on_department_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["invitation_token"], name: "index_users_on_invitation_token", unique: true
    t.index ["invitations_count"], name: "index_users_on_invitations_count"
    t.index ["invited_by_id"], name: "index_users_on_invited_by_id"
    t.index ["invited_by_type", "invited_by_id"], name: "index_users_on_invited_by_type_and_invited_by_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "vipr_items", force: :cascade do |t|
    t.bigint "vipr_id", null: false
    t.string "no"
    t.string "product"
    t.string "spesification"
    t.string "costcenter"
    t.decimal "price"
    t.decimal "quantity"
    t.decimal "amount"
    t.string "dept"
    t.string "description"
    t.string "item"
    t.string "status"
    t.index ["vipr_id"], name: "index_vipr_items_on_vipr_id"
  end

  create_table "vipr_reviews", force: :cascade do |t|
    t.string "name"
    t.string "title"
    t.string "email"
    t.decimal "plafond"
    t.integer "order"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "viprs", force: :cascade do |t|
    t.string "invoice_no"
    t.string "no"
    t.string "supplier"
    t.date "invoice_date"
    t.date "due_date"
    t.string "payment_no"
    t.string "currency"
    t.string "requester"
    t.string "approval1"
    t.datetime "apv_date1"
    t.string "approval2"
    t.datetime "apv_date2"
    t.string "approval3"
    t.datetime "apv_date3"
    t.string "approval4"
    t.datetime "apv_date4"
    t.string "remarks"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "status"
    t.string "req_email"
    t.decimal "subtotal"
    t.decimal "vat"
    t.decimal "total"
    t.integer "user_id"
    t.boolean "is_vat"
    t.string "po_no"
    t.string "pic"
    t.string "doctype"
    t.decimal "disc"
    t.decimal "totbefdisc"
    t.decimal "grand_total"
    t.string "source"
    t.string "sapno"
    t.decimal "dp"
    t.decimal "net_payment"
    t.decimal "dp_amount"
    t.string "verify1"
    t.string "verifyemail1"
    t.string "verifyemail2"
    t.string "verifyemail3"
    t.string "verify2"
    t.string "verify3"
    t.string "tipe"
    t.string "supplier_name"
    t.date "vdate1"
    t.date "vdate2"
    t.date "vdate3"
    t.string "approval_group"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "authorizations", "users"
  add_foreign_key "departments", "costcenters"
  add_foreign_key "departments", "expenses"
  add_foreign_key "purchase_order_items", "purchase_orders"
  add_foreign_key "purchase_request_items", "purchase_requests"
  add_foreign_key "users", "departments"
  add_foreign_key "vipr_items", "viprs"
end
