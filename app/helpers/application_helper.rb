# Methods added to this helper will be available to all templates in the application.


module ApplicationHelper
  


  # Return a link for use in site navigation.
  def nav_link(text, controller, action="index")
    link_to_unless_current text, :id => nil,
                                 :action => action,
                                 :controller => controller
  end

    def nav_link_id(text, controller, action,id)
    link_to_unless_current text, :id => id,
                                 :action => action,
                                 :controller => controller
  end

  
  # Return true if results should be paginated.
  def paginated?
    @pages and @pages.length > 1
  end
  
 
  
  def admin?
    if current_user.role == "admin"
      return true
    else
      return false
    end
    
  end
  
end
