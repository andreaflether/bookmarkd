# frozen_string_literal: true

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

ActiveRecord::Schema.define(version: 20_201_230_183_222) do
  create_table 'bookmarks', force: :cascade do |t|
    t.integer 'folder_id'
    t.integer 'tweet_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['folder_id'], name: 'index_bookmarks_on_folder_id'
    t.index ['tweet_id'], name: 'index_bookmarks_on_tweet_id'
  end

  create_table 'folders', force: :cascade do |t|
    t.integer 'user_id'
    t.string 'name'
    t.text 'description'
    t.boolean 'pinned', default: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.string 'slug'
    t.integer 'bookmarks_count', default: 0
    t.index ['slug'], name: 'index_folders_on_slug', unique: true
    t.index ['user_id'], name: 'index_folders_on_user_id'
  end

  create_table 'friendly_id_slugs', force: :cascade do |t|
    t.string 'slug', null: false
    t.integer 'sluggable_id', null: false
    t.string 'sluggable_type', limit: 50
    t.string 'scope'
    t.datetime 'created_at'
    t.index %w[slug sluggable_type scope], name: 'index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope',
                                           unique: true
    t.index %w[slug sluggable_type], name: 'index_friendly_id_slugs_on_slug_and_sluggable_type'
    t.index %w[sluggable_type sluggable_id], name: 'index_friendly_id_slugs_on_sluggable_type_and_sluggable_id'
  end

  create_table 'tweets', force: :cascade do |t|
    t.string 'link'
    t.text 'html_content'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'users', force: :cascade do |t|
    t.string 'email', null: false
    t.string 'encrypted_password', default: '', null: false
    t.string 'reset_password_token'
    t.datetime 'reset_password_sent_at'
    t.datetime 'remember_created_at'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.string 'name', default: '', null: false
    t.string 'username', default: '', null: false
    t.string 'image', default: '', null: false
    t.string 'provider'
    t.string 'uid'
    t.json 'preferences'
    t.index ['email'], name: 'index_users_on_email', unique: true
    t.index ['reset_password_token'], name: 'index_users_on_reset_password_token', unique: true
  end
end
