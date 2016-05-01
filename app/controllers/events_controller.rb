class EventsController < ApplicationController
  
#Les saque las librerias que tan en el application.rb

  before_filter :login_required, :except => [:show,:index]
  require_role "admin", :only => [:list]
  auto_complete_for :event, :address_event
  auto_complete_for :event, :city
    # Filtro que permite que un usuario sea eliminado o editado solo por los usuarios
  # con el permiso de hacerlo.
  before_filter :pertenencia_de_evento_edicion, :only => ['edit']
  
  def index

    
  #  respond_to do |wants|
   #   wants.html
    #  wants.xml { render :xml => @events.to_xml }
     # wants.rss { render :action => 'rss.rxml', :layout => false }
      #wants.atom { render :action => 'atom.rxml', :layout => false }
     #end
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @event_pages, @events = paginate :events, :per_page => 10
  end

  def show
    @event = Event.find(params[:id])
    
#    respond_to do |wants|
 #     wants.html
#      wants.xml { render :xml => @event.to_xml }
 #   end
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(params[:event])
    @event.user_id = params[:user_id]
    @event.tag_list.add(params[:tags]) if params[:tags]
    if @event.save
      flash[:notice] = 'Event was successfully created.'
      redirect_to :action => 'show', :id => @event
    else
      render :action => 'new'
    end
#    respond_to do |wants|
     # wants.html { redirect_to events_url }
#      wants.xml { render :xml => @events.to_xml }
 #   end
    
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])
     @event.user_id = params[:user_id]
     @event.tag_list.add(params[:tags]) if params[:tags]
    if @event.update_attributes(params[:event])
      flash[:notice] = 'Event was successfully updated.'
      redirect_to :action => 'show', :id => @event
    else
      render :action => 'edit'
    end
    
  #  respond_to do |wants|
      #wants.html { redirect_to events_url }
 #     wants.xml { render :xml => @events.to_xml }
   # end
  end

  def destroy
    Event.find(params[:id]).destroy
    redirect_to :action => 'list'
    
    #respond_to do |wants|
    #wants.html { redirect_to events_url }
  #  wants.xml { render :nothing => true }
    #end
  end
  
  def admin
       list
   render :action => 'list'
  end
  
  
  def es_mio?(event)
    if self.current_user.id == event.user_id
      return true
    else
      return false
    end
  end
  
      # Chequea los permisos para la edicion o eliminacion de un usuario
  private
  def pertenencia_de_evento_edicion
    event = Event.find(params[:id])
      unless self.es_mio?(event) or self.admin?
        flash[:notice] = l(:errors,:permission)
        redirect_to(:controller => "events", :action => "index")
        return false
      else
        return true
      end 

  end 
end
