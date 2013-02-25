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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130223172742) do

  create_table "addresses", :force => true do |t|
    t.string   "address"
    t.string   "address2"
    t.string   "country"
    t.string   "city"
    t.string   "state"
    t.string   "post_code"
    t.float    "lat"
    t.float    "lng"
    t.float    "user_set_lat"
    t.float    "user_set_lng"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "articles", :force => true do |t|
    t.integer  "source_id"
    t.string   "source_type"
    t.string   "title"
    t.text     "description"
    t.string   "group"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "articles", ["source_type", "source_id"], :name => "index_articles_on_source_type_and_source_id"

  create_table "calendars", :force => true do |t|
    t.string   "path"
    t.string   "provider"
    t.boolean  "enabled"
    t.integer  "property_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "calendars", ["property_id"], :name => "index_calendars_on_property_id"
  add_index "calendars", ["provider", "property_id"], :name => "index_calendars_on_provider_and_property_id"

  create_table "directions", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.integer  "property_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "identities", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.string   "provider"
    t.integer  "user_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.string   "state"
  end

  create_table "properties", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.integer  "site_id"
    t.integer  "address_id"
    t.integer  "user_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "properties", ["site_id"], :name => "index_properties_on_site_id"

  create_table "property_photos", :force => true do |t|
    t.string   "image"
    t.integer  "property_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "sites", :force => true do |t|
    t.string   "title"
    t.string   "subdomain"
    t.string   "domain"
    t.string   "style"
    t.string   "email"
    t.string   "phone"
    t.integer  "address_id"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "sites", ["domain"], :name => "index_sites_on_domain"
  add_index "sites", ["subdomain"], :name => "index_sites_on_subdomain"

  create_table "users", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "guid"
    t.string   "state"
    t.integer  "address_id"
    t.string   "phone"
  end

end
