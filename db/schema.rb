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

ActiveRecord::Schema[7.0].define(version: 2025_07_14_214601) do
  create_table "active_admin_comments", force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_type"
    t.integer "resource_id"
    t.string "author_type"
    t.integer "author_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource"
  end

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
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "admin_users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
  end

  create_table "badges", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.string "badgeable_type", null: false
    t.integer "badgeable_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["badgeable_type", "badgeable_id"], name: "index_badges_on_badgeable"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "sponsor_badge"
    t.string "headline_h1"
    t.string "headline_h2"
    t.string "headline_h3"
    t.string "meta_title"
    t.text "meta_description"
    t.string "og_image"
    t.string "slug"
  end

  create_table "features", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "active", default: true, null: false
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string "slug", null: false
    t.integer "sluggable_id", null: false
    t.string "sluggable_type", limit: 50
    t.string "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
    t.index ["sluggable_type", "sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_type_and_sluggable_id"
  end

  create_table "noticed_events", force: :cascade do |t|
    t.string "type"
    t.string "record_type"
    t.bigint "record_id"
    t.json "params"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "notifications_count"
    t.index ["record_type", "record_id"], name: "index_noticed_events_on_record"
  end

  create_table "noticed_notifications", force: :cascade do |t|
    t.string "type"
    t.bigint "event_id", null: false
    t.string "recipient_type", null: false
    t.bigint "recipient_id", null: false
    t.datetime "read_at", precision: nil
    t.datetime "seen_at", precision: nil
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_noticed_notifications_on_event_id"
    t.index ["recipient_type", "recipient_id"], name: "index_noticed_notifications_on_recipient"
  end

  create_table "plan_features", force: :cascade do |t|
    t.integer "plan_id", null: false
    t.integer "feature_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["feature_id"], name: "index_plan_features_on_feature_id"
    t.index ["plan_id"], name: "index_plan_features_on_plan_id"
  end

  create_table "plans", force: :cascade do |t|
    t.string "name"
    t.decimal "price", precision: 10, scale: 2
    t.string "duration"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "active"
    t.text "description"
    t.integer "duration_months"
  end

  create_table "posts", force: :cascade do |t|
    t.string "title"
    t.text "body"
    t.datetime "published_at"
    t.integer "solar_user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["solar_user_id"], name: "index_posts_on_solar_user_id"
  end

  create_table "review_campaigns", force: :cascade do |t|
    t.integer "solar_company_id", null: false
    t.integer "user_id", null: false
    t.string "title"
    t.datetime "start_date"
    t.datetime "end_date"
    t.integer "created_by_id"
    t.integer "updated_by_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["solar_company_id"], name: "index_review_campaigns_on_solar_company_id"
    t.index ["user_id"], name: "index_review_campaigns_on_user_id"
  end

  create_table "saas_access_managements", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "access_level", default: "read", null: false
    t.string "status", default: "pending", null: false
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_saas_access_managements_on_user_id"
  end

  create_table "saas_members", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "plan_id", null: false
    t.string "subscription_status", default: "pending", null: false
    t.decimal "billing_amount", precision: 10, scale: 2
    t.datetime "billing_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["plan_id"], name: "index_saas_members_on_plan_id"
    t.index ["user_id"], name: "index_saas_members_on_user_id"
  end

  create_table "saas_sponsoreds", force: :cascade do |t|
    t.integer "solar_company_id", null: false
    t.datetime "start_date"
    t.datetime "end_date"
    t.decimal "budget", precision: 10, scale: 2
    t.integer "created_by_id"
    t.integer "updated_by_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["solar_company_id"], name: "index_saas_sponsoreds_on_solar_company_id"
  end

  create_table "solar_companies", force: :cascade do |t|
    t.string "name"
    t.string "location"
    t.decimal "installed_capacity_mwp", precision: 10, scale: 2, null: false
    t.string "status", default: "pending", null: false
    t.integer "created_by_id"
    t.integer "updated_by_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug", null: false
    t.string "cnpj", null: false
    t.string "street_address", null: false
    t.string "city", null: false
    t.string "state", null: false
    t.string "postal_code"
    t.decimal "latitude", precision: 10, scale: 6
    t.decimal "longitude", precision: 10, scale: 6
    t.string "contact_name", null: false
    t.string "contact_email", null: false
    t.string "contact_phone"
    t.string "website"
    t.string "facebook_url"
    t.string "twitter_url"
    t.string "linkedin_url"
    t.date "commissioning_date"
    t.string "module_technology"
    t.string "module_brand"
    t.integer "module_count"
    t.string "inverter_brand"
    t.string "inverter_model"
    t.float "avg_rating", default: 0.0
    t.integer "reviews_count", default: 0
    t.decimal "total_energy_generated_mwh", precision: 12, scale: 2, default: "0.0"
    t.string "meta_title"
    t.string "meta_description"
    t.string "meta_keywords"
    t.datetime "deleted_at"
    t.string "title_h1"
    t.string "title_h2"
    t.boolean "show_breadcrumbs", default: false, null: false
    t.boolean "show_header", default: false, null: false
    t.boolean "show_search_reviews", default: false, null: false
    t.boolean "show_filter_by_rating", default: false, null: false
    t.boolean "show_sort_dropdown", default: false, null: false
    t.boolean "show_overall_rating", default: false, null: false
    t.boolean "show_rating_breakdown", default: false, null: false
    t.boolean "show_reviews_list", default: false, null: false
    t.boolean "show_pagination", default: false, null: false
    t.boolean "show_sidebar_top_companies", default: false, null: false
    t.index ["cnpj"], name: "index_solar_companies_on_cnpj", unique: true
    t.index ["created_by_id"], name: "index_solar_companies_on_created_by_id"
    t.index ["deleted_at"], name: "index_solar_companies_on_deleted_at"
    t.index ["slug"], name: "index_solar_companies_on_slug", unique: true
    t.index ["updated_by_id"], name: "index_solar_companies_on_updated_by_id"
  end

  create_table "solar_contents", force: :cascade do |t|
    t.integer "solar_company_id", null: false
    t.integer "user_id", null: false
    t.string "title"
    t.string "content_type"
    t.text "body"
    t.integer "category_id"
    t.integer "created_by_id"
    t.integer "updated_by_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_solar_contents_on_category_id"
    t.index ["solar_company_id"], name: "index_solar_contents_on_solar_company_id"
    t.index ["user_id"], name: "index_solar_contents_on_user_id"
  end

  create_table "solar_reviews", force: :cascade do |t|
    t.integer "solar_company_id", null: false
    t.integer "user_id", null: false
    t.integer "rating"
    t.text "comment"
    t.string "status"
    t.integer "review_campaign_id"
    t.integer "created_by_id"
    t.integer "updated_by_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["review_campaign_id"], name: "index_solar_reviews_on_review_campaign_id"
    t.index ["solar_company_id"], name: "index_solar_reviews_on_solar_company_id"
    t.index ["user_id"], name: "index_solar_reviews_on_user_id"
  end

  create_table "solar_users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "name"
    t.integer "role", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "created_by_id"
    t.integer "updated_by_id"
    t.string "status", default: "pending", null: false
    t.index ["email"], name: "index_solar_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_solar_users_on_reset_password_token", unique: true
  end

  create_table "subcategories", force: :cascade do |t|
    t.string "name"
    t.string "slug"
    t.boolean "sponsored"
    t.integer "category_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "sponsor_badge"
    t.string "headline_h1"
    t.string "headline_h2"
    t.string "headline_h3"
    t.string "meta_title"
    t.text "meta_description"
    t.string "og_image"
    t.index ["category_id"], name: "index_subcategories_on_category_id"
    t.index ["slug"], name: "index_subcategories_on_slug", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "plan_features", "features"
  add_foreign_key "plan_features", "plans"
  add_foreign_key "posts", "solar_users"
  add_foreign_key "review_campaigns", "solar_companies"
  add_foreign_key "review_campaigns", "solar_users", column: "user_id"
  add_foreign_key "saas_access_managements", "solar_users", column: "user_id"
  add_foreign_key "saas_members", "plans"
  add_foreign_key "saas_members", "solar_users", column: "user_id"
  add_foreign_key "saas_sponsoreds", "solar_companies"
  add_foreign_key "solar_companies", "solar_users", column: "created_by_id"
  add_foreign_key "solar_companies", "solar_users", column: "updated_by_id"
  add_foreign_key "solar_contents", "categories"
  add_foreign_key "solar_contents", "solar_companies"
  add_foreign_key "solar_contents", "solar_users", column: "user_id"
  add_foreign_key "solar_reviews", "review_campaigns"
  add_foreign_key "solar_reviews", "solar_companies"
  add_foreign_key "solar_reviews", "solar_users", column: "user_id"
  add_foreign_key "subcategories", "categories"
end
