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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110921014000) do

  create_table "contact_calls", :force => true do |t|
    t.integer  "user_id",                                        :null => false
    t.integer  "contact_id",                                     :null => false
    t.datetime "called_at",   :default => '2011-11-19 18:12:56', :null => false
    t.integer  "duraction",   :default => 1
    t.string   "topic"
    t.text     "description"
    t.string   "evaluation",  :default => "good"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "contact_calls", ["called_at"], :name => "index_contact_calls_on_called_at"
  add_index "contact_calls", ["contact_id"], :name => "index_contact_calls_on_contact_id"
  add_index "contact_calls", ["evaluation"], :name => "index_contact_calls_on_evaluation"
  add_index "contact_calls", ["topic"], :name => "index_contact_calls_on_topic"

  create_table "contact_details", :force => true do |t|
    t.integer  "contact_id",                                                   :null => false
    t.string   "facial_tone_base"
    t.string   "skin_type",                              :default => "normal"
    t.string   "skin_tone",                              :default => "ivory"
    t.boolean  "has_interest_aging_and_cellulite",       :default => false
    t.boolean  "has_interest_appearance_and_staining",   :default => false
    t.boolean  "has_interest_aging_and_expression_line", :default => false
    t.boolean  "has_interest_fine_wrinkle",              :default => false
    t.boolean  "has_interest_become_a_member",           :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "contacts", :force => true do |t|
    t.integer  "user_id",                                                                   :null => false
    t.integer  "friend_id"
    t.string   "name",                                                                      :null => false
    t.string   "email"
    t.string   "twitter"
    t.string   "social_network_url"
    t.integer  "score",                                              :default => 0
    t.date     "date_of_birth"
    t.string   "hostess"
    t.text     "address"
    t.decimal  "latitude",            :precision => 10, :scale => 6, :default => -15.79171
    t.decimal  "longitude",           :precision => 10, :scale => 6, :default => -47.88935
    t.string   "telephone"
    t.string   "mobile_phone"
    t.text     "notes"
    t.datetime "deleted_at"
    t.integer  "last_order_id"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "contacts", ["date_of_birth"], :name => "index_contacts_on_date_of_birth"
  add_index "contacts", ["email"], :name => "index_contacts_on_email"
  add_index "contacts", ["mobile_phone"], :name => "index_contacts_on_mobile_phone"
  add_index "contacts", ["name"], :name => "index_contacts_on_name"
  add_index "contacts", ["telephone"], :name => "index_contacts_on_telephone"
  add_index "contacts", ["user_id"], :name => "index_contacts_on_user_id"

  create_table "events", :force => true do |t|
    t.integer  "user_id",                            :null => false
    t.integer  "reminder_id"
    t.string   "title"
    t.datetime "start_at",                           :null => false
    t.datetime "end_at",                             :null => false
    t.string   "location"
    t.text     "description"
    t.string   "show_as",      :default => "busy"
    t.string   "privacy",      :default => "public"
    t.string   "evaluation",   :default => "good"
    t.datetime "confirmed_at"
    t.datetime "canceled_at"
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "events", ["user_id"], :name => "index_events_on_user_id"

  create_table "order_items", :force => true do |t|
    t.integer  "order_id",                                                        :null => false
    t.integer  "product_id",                                                      :null => false
    t.decimal  "price",      :precision => 8, :scale => 2,                        :null => false
    t.integer  "quantity",                                 :default => 1,         :null => false
    t.string   "status",                                   :default => "waiting"
    t.datetime "shipped_at"
  end

  add_index "order_items", ["order_id"], :name => "index_order_items_on_order_id"
  add_index "order_items", ["product_id"], :name => "index_order_items_on_product_id"

  create_table "orders", :force => true do |t|
    t.integer  "user_id",                                                                       :null => false
    t.integer  "contact_id"
    t.string   "order_type",                                 :default => "out",                 :null => false
    t.decimal  "total_price",  :precision => 8, :scale => 2,                                    :null => false
    t.string   "status",                                     :default => "open"
    t.text     "notes"
    t.datetime "ordered_at",                                 :default => '2011-11-19 18:12:56', :null => false
    t.datetime "completed_at"
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "orders", ["order_type"], :name => "index_orders_on_order_type"
  add_index "orders", ["ordered_at"], :name => "index_orders_on_ordered_at"
  add_index "orders", ["user_id"], :name => "index_orders_on_user_id"

  create_table "product_inventories", :force => true do |t|
    t.integer  "user_id",                   :null => false
    t.integer  "product_id",                :null => false
    t.integer  "max",        :default => 1
    t.integer  "min",        :default => 0
    t.integer  "count",      :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "product_inventories", ["user_id", "product_id"], :name => "index_product_inventories_on_user_id_and_product_id", :unique => true

  create_table "products", :force => true do |t|
    t.string   "name",                                                  :null => false
    t.text     "description"
    t.string   "sku"
    t.decimal  "price",                   :precision => 8, :scale => 2, :null => false
    t.datetime "deleted_at"
    t.string   "attachment_file_name"
    t.string   "attachment_content_type"
    t.integer  "attachment_file_size"
    t.datetime "attachment_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "products", ["description"], :name => "index_products_on_description"
  add_index "products", ["name"], :name => "index_products_on_name"
  add_index "products", ["sku"], :name => "index_products_on_sku", :unique => true

  create_table "profiles", :force => true do |t|
    t.integer  "user_id",                                     :null => false
    t.string   "name"
    t.string   "code"
    t.string   "position"
    t.string   "location"
    t.string   "area"
    t.string   "hometown"
    t.text     "biography"
    t.string   "telephone"
    t.string   "mobile_phone"
    t.date     "date_of_birth"
    t.string   "web"
    t.boolean  "welcome",             :default => true
    t.string   "time_zone",           :default => "Brasilia"
    t.string   "language",            :default => "pt-BR"
    t.string   "first_day_of_week",   :default => "sunday"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "profiles", ["location"], :name => "index_profiles_on_location"
  add_index "profiles", ["name"], :name => "index_profiles_on_name"
  add_index "profiles", ["position"], :name => "index_profiles_on_position"
  add_index "profiles", ["user_id"], :name => "index_profiles_on_user_id", :unique => true

  create_table "reminders", :force => true do |t|
    t.integer  "user_id",                            :null => false
    t.string   "title"
    t.text     "description"
    t.integer  "reference_id"
    t.string   "reference_type", :default => "task"
    t.datetime "scheduled_at",                       :null => false
    t.boolean  "confirmed",      :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "reminders", ["confirmed"], :name => "index_reminders_on_confirmed"
  add_index "reminders", ["reference_id"], :name => "index_reminders_on_reference_id"
  add_index "reminders", ["scheduled_at"], :name => "index_reminders_on_scheduled_at"
  add_index "reminders", ["user_id"], :name => "index_reminders_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "email",                               :default => "",    :null => false
    t.string   "encrypted_password",   :limit => 128, :default => "",    :null => false
    t.string   "reset_password_token"
    t.string   "remember_token"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                       :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "super_user",                          :default => false
  end

  add_index "users", ["confirmation_token"], :name => "index_users_on_confirmation_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
