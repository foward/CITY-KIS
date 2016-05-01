class CreateEvents < ActiveRecord::Migration
  
  def self.up
    
     create_table :events do |t|
       
      t.column :title, :string, :null =>false, :limit =>80, :null =>false
      t.column :description, :text, :null =>false
      t.column :price_before, :decimal, :null =>false, :default=>0.0
      t.column :price_after, :decimal, :null =>false, :default=>0.0
      t.column :price_special, :decimal, :null =>false, :default=>0.0
      t.column :time_event, :time 
      t.column :date_event, :date, :null=>false
      t.column :created_at, :datetime
      t.column :updated_at, :datetime
      t.column :language, :string
      t.column :vote_count, :integer
      t.column :comment_count, :integer
      t.column :user_id, :integer, :null=>false
      t.column :category_id, :integer, :null=>false
      t.column :link_id, :integer, :null=>false
      t.column :photo_id, :integer, :null=>false
      t.column :homepage, :string
      t.column :users_attending, :integer
      
      t.column :address_event, :string, :limit => 50, :null =>false
      t.column :postal_code, :integer, :null => false
      t.column :city, :string, :limit => 50 ,:null =>false
      t.column :country, :string, :limit => 50 ,:null =>false
      t.column :address_buy_tickets_1, :string, :limit => 90 ,:null =>false
      t.column :address_buy_tickets_2, :string, :limit => 90 ,:null =>false
      t.column :comments_count, :int, :null =>false
      t.column :event_top, :boolean, :null=>false, :default=>0
       
     end
  end

  def self.down
     drop_table :events
  end
end
