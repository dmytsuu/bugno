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

ActiveRecord::Schema.define(version: 2019_12_06_175353) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_type"
    t.bigint "resource_id"
    t.string "author_type"
    t.bigint "author_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id"
  end

  create_table "events", force: :cascade do |t|
    t.bigint "project_id"
    t.bigint "user_id"
    t.string "title"
    t.string "environment"
    t.integer "status", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "message"
    t.jsonb "backtrace", default: [], array: true
    t.string "framework"
    t.string "url"
    t.string "ip_address"
    t.jsonb "headers"
    t.string "http_method"
    t.jsonb "params"
    t.integer "position"
    t.jsonb "server_data"
    t.integer "parent_id"
    t.jsonb "person_data"
    t.jsonb "route_params"
    t.integer "occurrence_count", default: 0
    t.datetime "last_occurrence_at"
    t.jsonb "background_data"
    t.index ["parent_id"], name: "index_events_on_parent_id"
    t.index ["project_id"], name: "index_events_on_project_id"
    t.index ["user_id"], name: "index_events_on_user_id"
  end

  create_table "integrations", force: :cascade do |t|
    t.bigint "project_id"
    t.string "type"
    t.jsonb "provider_data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["project_id"], name: "index_integrations_on_project_id"
  end

  create_table "plans", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.integer "event_limit"
    t.decimal "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "project_users", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "project_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "role", default: 0
    t.index ["project_id"], name: "index_project_users_on_project_id"
    t.index ["user_id"], name: "index_project_users_on_user_id"
  end

  create_table "projects", force: :cascade do |t|
    t.string "name"
    t.string "api_key"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
    t.integer "active_event_count", default: 0, null: false
    t.index ["slug"], name: "index_projects_on_slug", unique: true
  end

  create_table "subscriptions", force: :cascade do |t|
    t.date "expires_at"
    t.integer "status", default: 0
    t.integer "events", default: 0
    t.bigint "project_id"
    t.bigint "plan_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "customer_id"
    t.index ["plan_id"], name: "index_subscriptions_on_plan_id"
    t.index ["project_id"], name: "index_subscriptions_on_project_id", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "provider", default: "email", null: false
    t.string "uid", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.boolean "allow_password_change", default: false
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.string "name"
    t.string "nickname"
    t.string "image"
    t.string "email"
    t.json "tokens"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["uid", "provider"], name: "index_users_on_uid_and_provider", unique: true
  end

  add_foreign_key "events", "projects"
  add_foreign_key "events", "users"
  add_foreign_key "integrations", "projects"
  add_foreign_key "project_users", "projects"
  add_foreign_key "project_users", "users"
  add_foreign_key "subscriptions", "plans"
  add_foreign_key "subscriptions", "projects"
end
