# This file is autogenerated. Instead of editing this file, please use the
# migrations feature of ActiveRecord to incrementally modify your database, and
# then regenerate this schema definition.

ActiveRecord::Schema.define(:version => 7) do

  create_table "categories", :force => true do |t|
    t.column "name",     :string,  :default => "", :null => false
    t.column "event_id", :integer
  end

  create_table "events", :force => true do |t|
    t.column "title",                 :string,   :limit => 80,                                :default => "",        :null => false
    t.column "description",           :text,                                                  :default => "",        :null => false
    t.column "price_after",           :integer,  :limit => 10, :precision => 10, :scale => 0, :default => 0,         :null => false
    t.column "time_event",            :time
    t.column "date_event",            :date,                                                                         :null => false
    t.column "created_at",            :datetime
    t.column "updated_at",            :datetime
    t.column "language",              :string
    t.column "vote_count",            :integer,                                               :default => 0
    t.column "comment_count",         :integer
    t.column "user_id",               :integer
    t.column "category_id",           :integer
    t.column "link_id",               :integer
    t.column "photo_path",            :string
    t.column "homepage",              :string,                                                :default => "http://"
    t.column "users_attending",       :integer,                                               :default => 0
    t.column "address_event",         :string,   :limit => 50,                                :default => "",        :null => false
    t.column "postal_code",           :integer,                                                                      :null => false
    t.column "city",                  :string,   :limit => 50,                                :default => "",        :null => false
    t.column "country",               :string,   :limit => 50,                                :default => "",        :null => false
    t.column "address_buy_tickets_1", :string,   :limit => 90,                                :default => "",        :null => false
    t.column "address_buy_tickets_2", :string,   :limit => 90,                                :default => "",        :null => false
    t.column "comments_count",        :integer,                                               :default => 0
    t.column "event_top",             :boolean,                                               :default => false,     :null => false
    t.column "price_before",          :integer,  :limit => 10, :precision => 10, :scale => 0, :default => 0,         :null => false
    t.column "price_special",         :integer,  :limit => 10, :precision => 10, :scale => 0, :default => 0,         :null => false
    t.column "forum_direction",       :string,   :limit => 45
  end

  add_index "events", ["category_id"], :name => "category_Index_3"
  add_index "events", ["user_id"], :name => "organizer_Index_1"

  create_table "taggings", :force => true do |t|
    t.column "tag_id",        :integer
    t.column "taggable_id",   :integer
    t.column "taggable_type", :string
    t.column "created_at",    :datetime
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type"], :name => "index_taggings_on_taggable_id_and_taggable_type"

  create_table "tags", :force => true do |t|
    t.column "name", :string
  end

  create_table "users", :force => true do |t|
    t.column "login",                     :string
    t.column "email",                     :string
    t.column "crypted_password",          :string,   :limit => 40
    t.column "salt",                      :string,   :limit => 40
    t.column "created_at",                :datetime
    t.column "updated_at",                :datetime
    t.column "remember_token",            :string
    t.column "remember_token_expires_at", :datetime
    t.column "name",                      :string,   :limit => 80, :default => "",    :null => false
    t.column "lastname",                  :string,   :limit => 80, :default => "",    :null => false
    t.column "telephone",                 :integer,  :limit => 12
    t.column "address",                   :string,   :limit => 50
    t.column "postal_code",               :integer,                                   :null => false
    t.column "city",                      :string,                 :default => "",    :null => false
    t.column "country",                   :string,   :limit => 10, :default => "",    :null => false
    t.column "state",                     :string,   :limit => 60
    t.column "has_car",                   :boolean,                :default => false
    t.column "preferences",               :string
    t.column "event_id",                  :integer
    t.column "name_organizer",            :string,   :limit => 20
    t.column "telephone_organizer",       :string,   :limit => 10
    t.column "area_code_organizer",       :string,   :limit => 3,  :default => "",    :null => false
    t.column "address_organizer",         :string,   :limit => 50, :default => "",    :null => false
    t.column "postal_code_organizer",     :integer,  :limit => 5,  :default => 0,     :null => false
    t.column "state_organizer",           :string,   :limit => 60, :default => "",    :null => false
    t.column "city_organizer",            :string,   :limit => 20, :default => "",    :null => false
    t.column "area_code",                 :string,   :limit => 3,  :default => "",    :null => false
    t.column "role",                      :string,   :limit => 20
    t.column "driver_id",                 :integer
    t.column "birthday",                  :date
    t.column "has_role",                  :integer,  :limit => 4,  :default => 0,     :null => false
  end

  add_index "users", ["role"], :name => "index_users_on_role"
  add_index "users", ["event_id"], :name => "fk_users_event"

end
