class Event < ActiveRecord::Base
  acts_as_taggable
  
  #indexes_columns :title,:address
   
  image_column :photo_path
  
  belongs_to :category, :class_name => "Category", :foreign_key => "category_id"
  
  belongs_to :user, :class_name => "User", :foreign_key => "user_id"
  
  validates_size_of :photo_path, :maximum => 200000000, :message => "is too big, must be smaller than 2MB!", :if =>:hay_photo?
  validates_presence_of :title,:description,:price_before,:price_after,:address_event,:city,:tag_list,:address_buy_tickets_1
 validates_numericality_of :postal_code,:price_before,:price_after,:price_special,:forum_direction
                     
                     
                     
  def hay_photo?
    if self.photo_path == nil
      return false
    else
      return true
    end
  end
  
  
  
end
