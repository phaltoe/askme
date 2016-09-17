class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  include Pundit
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  
  protect_from_forgery with: :exception

  before_filter :store_current_location, :unless => :devise_controller?

  before_action :configure_permitted_parameters, if: :devise_controller?


  def after_sign_in_path_for(resource)
    sign_in_url = new_user_session_url
    if request.referer == sign_in_url
      super
    else
      stored_location_for(resource) || request.referer || root_path
    end
  end

 

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :role])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :role])
  end

  def store_current_location
    store_location_for(:user, request.url)
  end

  private
 
  def record_not_found
    render errors_not_found_path, status: 404
  end  
end
