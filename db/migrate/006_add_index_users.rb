class AddIndexUsers < ActiveRecord::Migration
  def self.up
    
    add_index "users", ["event_id"], :name=> "fk_users_event"
     add_index "categories", ["event_id"], :name=> "fk_categories_event"
  end

  def self.down
  end
end
