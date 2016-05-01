class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.column :login,                     :string
      t.column :email,                     :string
      t.column :crypted_password,          :string, :limit => 40
      t.column :salt,                      :string, :limit => 40
      t.column :created_at,                :datetime
      t.column :updated_at,                :datetime
      t.column :remember_token,            :string
      t.column :remember_token_expires_at, :datetime
      #Datos Basicos
      t.column :name,                       :string, :null =>false, :limit =>80
      t.column :lastname,                   :string, :null =>false, :limit =>80
      t.column :telephone,                  :integer,:limit =>12 
      t.column :address,                    :string, :limit => 50 
      t.column :postal_code,                :integer, :null=>false
      t.column :city,                       :string, :null =>false
      t.column :country,                    :string, :limit => 10, :null=>false
      t.column :state,                      :string, :limit => 60
      t.column :has_car,                    :boolean , :default => false
      t.column :preferences,                :string
      t.column :event_id, :integer
     
        #falta esto
     
      #
    end
  end

  def self.down
    drop_table :users
  end
end
