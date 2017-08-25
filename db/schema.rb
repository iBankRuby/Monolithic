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

ActiveRecord::Schema.define(version: 20170824072549) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "account_users", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "account_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "rule_id"
    t.bigint "role_id"
    t.datetime "deleted_at"
    t.index ["account_id"], name: "index_account_users_on_account_id"
    t.index ["deleted_at"], name: "index_account_users_on_deleted_at"
    t.index ["role_id"], name: "index_account_users_on_role_id"
    t.index ["rule_id"], name: "index_account_users_on_rule_id"
    t.index ["user_id"], name: "index_account_users_on_user_id"
  end

  create_table "accounts", force: :cascade do |t|
    t.float "balance"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "iban"
    t.datetime "deleted_at"
    t.string "hash_id"
    t.index ["deleted_at"], name: "index_accounts_on_deleted_at"
  end

  create_table "exceeding_requests", force: :cascade do |t|
    t.decimal "amount", precision: 10, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "status"
    t.bigint "account_id"
    t.bigint "user_id"
    t.index ["account_id"], name: "index_exceeding_requests_on_account_id"
    t.index ["user_id"], name: "index_exceeding_requests_on_user_id"
  end

  create_table "invites", force: :cascade do |t|
    t.bigint "account_id"
    t.integer "user_from_id", null: false
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "user_to_email", null: false
    t.index ["account_id"], name: "index_invites_on_account_id"
  end

  create_table "invites_trackers", force: :cascade do |t|
    t.bigint "invite_id"
    t.float "limit"
    t.datetime "pending_time"
    t.float "time_in_pending"
    t.float "total_time"
    t.string "cause"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["invite_id"], name: "index_invites_trackers_on_invite_id"
  end

  create_table "limits", force: :cascade do |t|
    t.integer "reminder", default: 50
    t.boolean "movable", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "account_user_id"
    t.datetime "deleted_at"
    t.bigint "rules_id"
    t.index ["account_user_id"], name: "index_limits_on_account_user_id"
    t.index ["deleted_at"], name: "index_limits_on_deleted_at"
    t.index ["rules_id"], name: "index_limits_on_rules_id"
  end

  create_table "que_jobs", primary_key: ["queue", "priority", "run_at", "job_id"], force: :cascade, comment: "3" do |t|
    t.integer "priority", limit: 2, default: 100, null: false
    t.datetime "run_at", default: -> { "now()" }, null: false
    t.bigserial "job_id", null: false
    t.text "job_class", null: false
    t.json "args", default: [], null: false
    t.integer "error_count", default: 0, null: false
    t.text "last_error"
    t.text "queue", default: "", null: false
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
  end

  create_table "rules", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "spending_limit", precision: 10, scale: 4
    t.bigint "invite_id"
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_rules_on_deleted_at"
    t.index ["invite_id"], name: "index_rules_on_invite_id"
  end

  create_table "trans_trackers", force: :cascade do |t|
    t.bigint "transaction_id"
    t.datetime "pending_time"
    t.float "time_in_pending"
    t.datetime "in_process_time"
    t.float "time_in_process"
    t.datetime "in_approve_time"
    t.float "time_in_approve"
    t.float "total_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "cause"
    t.index ["transaction_id"], name: "index_trans_trackers_on_transaction_id"
  end

  create_table "transactions", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "account_id"
    t.string "remote_account_iban"
    t.float "summ"
    t.boolean "status_to", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "status_from"
    t.integer "remainder"
    t.float "balance"
    t.float "balance_after"
    t.float "remote_balance_after"
    t.index ["account_id"], name: "index_transactions_on_account_id"
    t.index ["user_id"], name: "index_transactions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "account_users", "roles"
  add_foreign_key "account_users", "rules"
  add_foreign_key "exceeding_requests", "accounts"
  add_foreign_key "exceeding_requests", "users"
  add_foreign_key "limits", "account_users"
  add_foreign_key "limits", "rules", column: "rules_id"
  add_foreign_key "rules", "invites"
end
