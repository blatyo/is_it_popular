# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100706155011) do

  create_table "page_ranks", :force => true do |t|
    t.string   "site",                :null => false
    t.integer  "alexa_rank",          :null => false
    t.integer  "google_rank",         :null => false
    t.integer  "alexa_backlinks",     :null => false
    t.integer  "alltheweb_backlinks", :null => false
    t.integer  "altavista_backlinks", :null => false
    t.integer  "bing_backlinks",      :null => false
    t.integer  "google_backlinks",    :null => false
    t.integer  "yahoo_backlinks",     :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "page_ranks", ["site"], :name => "index_page_ranks_on_site"

end
