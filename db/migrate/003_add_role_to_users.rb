class AddRoleToUsers < ActiveRecord::Migration
  def self.up
    add_column "users", :role, :string, :limit => 20
    add_column "users", :driver_id, :integer
    add_column "users", :birthday, :date
    add_column "users", :has_role, :boolean
    
    add_index "users", :role
  end

  def self.down
    remove_column "users", :role
  end
end