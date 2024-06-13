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

ActiveRecord::Schema[7.1].define(version: 2024_06_13_073514) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "dynamic_records", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "dynamic_struct_id", null: false
    t.jsonb "data", default: {}, null: false
    t.string "fields_recordable_type"
    t.uuid "fields_recordable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["dynamic_struct_id"], name: "index_dynamic_records_on_dynamic_struct_id"
    t.index ["fields_recordable_type", "fields_recordable_id"], name: "index_dynamic_records_on_fields_recordable"
  end

  create_table "dynamic_structs", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name", null: false
    t.jsonb "struct", default: {}, null: false
    t.string "fields_structable_type"
    t.uuid "fields_structable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["fields_structable_type", "fields_structable_id"], name: "index_dynamic_structs_on_fields_structable"
  end

  create_table "tenants", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "tenant_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tenant_id"], name: "index_users_on_tenant_id"
  end

  add_foreign_key "dynamic_records", "dynamic_structs"
  add_foreign_key "users", "tenants"
end
