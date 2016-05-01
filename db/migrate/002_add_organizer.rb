class AddOrganizer < ActiveRecord::Migration
  def self.up
    add_column "users", :name_organizer, :string, :limit => 20
    add_column "users", :area_code_organizer, :string, :limit => 3, :default=>"",:null =>false
    add_column "users", :telephone_organizer, :string, :limit => 10 , :default=>""   
    add_column "users", :address_organizer, :string, :limit => 50, :null =>false , :default=>""
    add_column "users", :postal_code_organizer, :integer, :limit => 6, :null =>false , :default=>0
    add_column "users", :state_organizer, :string, :limit => 60, :null =>false, :default=>""
    add_column "users", :city_organizer, :string, :limit => 20, :null =>false, :default=>""
   
   
   add_column "users", :area_code, :string, :limit => 3, :null =>false, :default=>""
  end

  def self.down
        
    remove_column "users", :name_organizer
    remove_column "users", :area_code_organizer
    remove_column "users", :telephone_organizer
    remove_column "users", :address_organizer
    remove_column "users", :postal_code_organizer
    remove_column "users", :state_organizer
    remove_column "users", :city_organizer
    remove_column "users", :area_code
  end
  
end