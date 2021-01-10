class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :pinned_folders, if: :user_signed_in? 

  def pinned_folders
    @pinned = current_user.pinned_folders.order(name: :asc)
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

  def folder_belongs_to_user?(folder)
    current_user.id == folder.user.id
  end
  helper_method :folder_belongs_to_user?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :terms])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :order_folders_by])
  end
end