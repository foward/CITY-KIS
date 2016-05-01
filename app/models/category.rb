class Category < ActiveRecord::Base
  
   has_many :events, :dependent => true
  
end
