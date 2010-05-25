# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of ActiveRecord to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 18) do

  create_table "answers", :force => true do |t|
    t.string   "answer"
    t.integer  "question_id"
    t.integer  "option_id"
    t.integer  "response_id"
    t.boolean  "active"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "invitations", :force => true do |t|
    t.string   "email"
    t.integer  "survey_id"
    t.string   "token"
    t.boolean  "response",       :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "mail_sent",      :default => false
    t.boolean  "follow_up_sent", :default => false
  end

  create_table "options", :force => true do |t|
    t.integer "question_id"
    t.string  "label"
    t.integer "position"
  end

  create_table "question_types", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "description"
  end

  create_table "questions", :force => true do |t|
    t.string   "title"
    t.integer  "type_id"
    t.integer  "survey_id"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "mandatory"
    t.string   "help_text"
  end

  create_table "responses", :force => true do |t|
    t.integer  "survey_id"
    t.integer  "user_id"
    t.string   "ip_address"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :default => "", :null => false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "survey_types", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "surveys", :force => true do |t|
    t.text     "title"
    t.text     "introduction"
    t.datetime "starts_at"
    t.datetime "ends_at"
    t.integer  "created_by"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "thank_you_message"
    t.integer  "survey_type_id"
  end

  create_table "users", :force => true do |t|
    t.string   "login"
    t.string   "email"
    t.string   "crypted_password",          :limit => 40
    t.string   "salt",                      :limit => 40
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token"
    t.datetime "remember_token_expires_at"
    t.boolean  "admin"
  end

end
