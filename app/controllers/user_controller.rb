class UserController < ApplicationController

#Les saque las librerias que tan en el application.rb

  before_filter :login_required, :except => [:login,:signup]

  #require_role "user", :only => [:edit, :update,:show] # don't allow contractors to destroy
  #require_role "driver", :only => [:login]
  
  # Filtro que permite que un usuario sea eliminado o editado solo por los usuarios
  # con el permiso de hacerlo.
  before_filter :pertenencia_de_usuario_edicion, :only => ['edit']
  
  # Filtro que permite que un usuario sea visto solo por quien tenga los permisos.
  before_filter :pertenencia_de_usuario, :only => ['show']

  def soy_yo?(user)
    if self.current_user.id == user.id
      return true
    else
      return false
    end
  end
  

  
  def admin?
    if current_user.role == "admin"
      return true
    else
      return false
    end
    
  end
  
  
   def organizer?
    if current_user.role == "organizer" || current_user.role == "organizer-driver"
      return true
    else
      return false
    end
    
  end
  
  def index
    redirect_to(:action => 'signup') unless logged_in? || User.count > 0
    if organizer?
      list
     
    end
  end


  def list
    
    @event_pages, @events = paginate(:events, :conditions => ["user_id = ? ", @current_user.id],
                                         :per_page => 10,
                                         :order => 'created_at DESC')
  end
  
  
  def login
    return unless request.post?
    self.current_user = User.authenticate(params[:login], params[:password])
    if logged_in?
      if params[:remember_me] == "1"
        self.current_user.remember_me
        cookies[:auth_token] = { :value => self.current_user.remember_token , :expires => self.current_user.remember_token_expires_at }
      end
      redirect_back_or_default(:controller => '/user', :action => 'index')
      flash[:notice] = "Logged in successfully"
    end
  end

 def edit
    @user = User.find(params[:id])
 end
  
  
  #has_role =1 significa que es oranizador 
  #has_role =0 significa que NO es organizador
    
  def update
    @user = User.find(params[:id])
   

   if params[:has_role]== "1" && params[:has_car]== "1"

       @user.role ="organizer-driver"
       @user.has_car=true
     end
     if params[:has_role]== "1" and params[:has_car]== "0"
    
       @user.role ="organizer"
       @user.has_car=false
     end
     if params[:has_role] == "0" and params[:has_car] == "1"
  
       @user.role ="driver"
       @user.has_car =true
     end
     if params[:has_role] == "0" and params[:has_car]== "0"
        @user.role ="user"
        @user.has_car =false
     end
    if @user.update_attributes(params[:user])
      #MailerReactivo.deliver_notificar_cambio_perfil(@usuario, self.opciones_del_sistema.host_deploy)
      flash[:notice] = 'The user has been modified.'
      redirect_to :action => 'show', :id => @user
    else
      render :action => 'edit'
    end
  end
  
  def show
    @user = User.find(params[:id])
  end

  def signup
    @user = User.new(params[:user])
 if params[:has_role]== "1" && params[:has_car]== "1"
   
       @user.role ="organizer-driver"
       @user.has_car=true
     end
     if params[:has_role]== "1" and params[:has_car]== "0"
    
       @user.role ="organizer"
       @user.has_car=false
     end
     if params[:has_role] == "0" and params[:has_car] == "1"
   
       @user.role ="driver"
       @user.has_car =true
     end
     if params[:has_role] == "0" and params[:has_car]== "0"
        @user.role ="user"
        @user.has_car =false
     end
    return unless request.post?
    @user.save!
    self.current_user = @user
    redirect_back_or_default(:controller => '/user', :action => 'index')
    flash[:notice] = "Thanks for signing up!"
    rescue ActiveRecord::RecordInvalid
    render :action => 'signup'
  end
  
  def logout
    self.current_user.forget_me if logged_in?
    cookies.delete :auth_token
    reset_session
    flash[:notice] = "You have been logged out."
    redirect_back_or_default(:controller => '/user', :action => 'index')
  end
  
  
  
    # Chequea los permisos para la edicion o eliminacion de un usuario
  private
  def pertenencia_de_usuario_edicion
    user = User.find(params[:id])
      unless self.soy_yo?(user) or self.admin?
        flash[:notice] = l(:errors,:permission)
        redirect_to(:controller => "user", :action => "index")
        return false
      else
        return true
      end 

  end 
  
   # Chequea los permisos para mostrar o eliminacion de un usuario
  private
  def pertenencia_de_usuario
    user = User.find(params[:id])   
      unless self.soy_yo?(user) or self.admin?
        flash[:notice] = l(:errors,:permission)
        redirect_to(:controller => "user", :action => "index")
        return false
      else
        return true
      end 
  end 
  
end
