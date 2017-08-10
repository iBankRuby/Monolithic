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

ActiveRecord::Schema.define(version: 20170809085340) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "account_users", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "account_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "rule_id"
    t.bigint "limit_id"
    t.bigint "role_id"
    t.index ["account_id"], name: "index_account_users_on_account_id"
    t.index ["limit_id"], name: "index_account_users_on_limit_id"
    t.index ["role_id"], name: "index_account_users_on_role_id"
    t.index ["rule_id"], name: "index_account_users_on_rule_id"
    t.index ["user_id"], name: "index_account_users_on_user_id"
  end

  create_table "accounts", force: :cascade do |t|
    t.float "balance"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "iban"
    t.string "hash_id"
  end

  create_table "exceeding_requests", force: :cascade do |t|
    t.decimal "amount", precision: 10, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "account_user_id"
    t.boolean "status"
    t.index ["account_user_id"], name: "index_exceeding_requests_on_account_user_id"
  end

  create_table "invites", force: :cascade do |t|
    t.bigint "account_id"
    t.integer "user_from_id", null: false
    t.boolean "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "user_to_email", null: false
    t.index ["account_id"], name: "index_invites_on_account_id"
  end

  create_table "limits", force: :cascade do |t|
    t.integer "reminder", default: 50
    t.boolean "movable", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.bigint "limit_id"
    t.index ["limit_id"], name: "index_roles_on_limit_id"
  end

  create_table "rules", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "spending_limit", precision: 10, scale: 4
    t.bigint "invite_id"
    t.index ["invite_id"], name: "index_rules_on_invite_id"
  end

  create_table "transactions", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "account_id"
    t.string "remote_account_id"
    t.float "summ"
    t.boolean "status_from", default: true
    t.boolean "status_to", default: false
    t.datetime "checkout_from"
    t.datetime "checkout_to"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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

  add_foreign_key "account_users", "limits"
  add_foreign_key "account_users", "roles"
  add_foreign_key "account_users", "rules"
  add_foreign_key "exceeding_requests", "account_users"
  add_foreign_key "roles", "limits"
end
