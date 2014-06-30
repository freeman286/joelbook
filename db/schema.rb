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

ActiveRecord::Schema.define(:version => 20140630153321) do

  create_table "channels", :force => true do |t|
    t.string   "name"
    t.boolean  "private"
    t.boolean  "public"
    t.integer  "owner_user_id"
    t.integer  "secondary_owner_user_id"
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
  end

  create_table "channels_users", :id => false, :force => true do |t|
    t.integer "channel_id"
    t.integer "user_id"
  end

  create_table "images", :force => true do |t|
    t.string   "image_uid"
    t.string   "image_name"
    t.integer  "user_id"
    t.integer  "post_id"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.string   "original_image_url"
  end

  create_table "notifications", :force => true do |t|
    t.integer  "owner_user_id"
    t.integer  "secondary_owner_user_id"
    t.string   "resource_type"
    t.integer  "resource_id"
    t.string   "content"
    t.boolean  "read"
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
  end

  create_table "posts", :force => true do |t|
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.string   "name"
    t.integer  "user_id"
    t.string   "img_url"
    t.string   "youtube_url"
    t.string   "user_name"
    t.string   "user_img_url"
    t.integer  "channel_id"
    t.integer  "time"
  end

  create_table "user_friendships", :force => true do |t|
    t.integer  "user_id"
    t.integer  "friend_id"
    t.string   "state"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "user_friendships", ["user_id", "friend_id"], :name => "index_user_friendships_on_user_id_and_friend_id"

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "name"
    t.string   "avatar_uid"
    t.string   "avatar_name"
    t.integer  "avatar_width"
    t.integer  "avatar_height"
    t.string   "avatar_cropping"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["name"], :name => "index_users_on_name", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
