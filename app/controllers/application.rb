# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.


class ApplicationController < ActionController::Base
  

  
  # Pick a unique cookie name to distinguish our session data from others'
  include AuthenticatedSystem
  before_filter :login_from_cookie
  session :session_key => '_citykisfinal_session_id'
  # You can move this into a different controller, if you wish.  This module gives you the require_role helpers, and others.
  
  include RoleRequirementSystem
  include ApplicationHelper

  before_filter :set_preferred_language
    
    
protected

  def set_preferred_language
 
    if params[:language] && valid_language?(params[:language])
      set_language(params[:language])
    elsif cookies[:language].blank? || !valid_language?(cookies[:language])
      # this discards the ranking information which may be provided in the header - it doesn't quite matter since modern browsers the languages by descending preference anyway
      accepted_languages = request.env['HTTP_ACCEPT_LANGUAGE'].to_s.split(',').map { |l| l[0..1].to_sym  }
      set_language((accepted_languages & Localization.loaded_languages).first || Localization.loaded_languages.first)
    else
      set_language(cookies[:language])
    end
  end

  def set_language(lang)
    cookies[:language] = { :value => lang.to_s[0..1], :expires => 1.year.from_now } if cookies[:language] != lang.to_s
    Localization.current_language = lang.to_sym

  end

  def valid_language?(lang)
    Localization.loaded_languages.include?(lang.to_s[0..1].to_sym)
  end
  
end
