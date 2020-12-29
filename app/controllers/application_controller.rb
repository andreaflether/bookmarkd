class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :pinned_folders, if: :user_signed_in? 

  def pinned_folders
    @pinned = current_user.pinned_folders
  end

  def after_sign_in_path_for(resource)
    folders_path
  end

  def moon
    cookies.delete(:sun)
    redirect_to request.referer
  end

  def sun
    cookies[:sun] = { value: 'light mode on' }
    redirect_to request.referer
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) do |u| 
      u.permit(:name, :email, :password, :password_confirmation, :terms) 
    end
    devise_parameter_sanitizer.permit(:account_update) do |u| 
      u.permit(:name, :email, :password, :password_confirmation, :current_password)
    end
  end
end