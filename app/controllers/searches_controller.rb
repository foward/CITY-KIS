class SearchesController < ApplicationController
  
  auto_complete_for :event, :city
  
  def index
    
    
  end
  
  
    def list
        country = params[:id]
      
        if country == nil
              
           @event_pages, @events = paginate :events, :per_page => 10
             
               
         else
           if country == "\xD6sterreich"
                 country = "Austria"
               end
             @event_pages, @events = paginate(:events, :conditions => ["country = ? ", country],
                                                 :per_page => 10,
                                                 :order => 'created_at DESC')  
       end
        
    end
    
    def listing
      
      category_id = params[:id]
      
      @event_pages, @events = paginate(:events, :conditions => ["category_id = ? ", category_id],
                                                 :per_page => 10,
                                                 :order => 'created_at DESC')  
      
      render :action => 'list'
    end
  
     def results
      
      city = params[:id]
    
      @event_pages, @events = paginate(:events, :conditions => ["city = ? ", city],
                                                 :per_page => 10,
                                                 :order => 'created_at DESC')  
      
      render :action => 'list'
    end
                                         
end
