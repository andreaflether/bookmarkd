# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :pinned_folders, if: :user_signed_in?
  helper_method :user_has_access_to_folder?, :folder_belongs_to_user?, :can_access_folder?

  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      format.html { redirect_to forbidden_path, alert: exception.message }
    end
  end

  def pinned_folders
    @pinned = current_user.pinned_folders
                          .order(name: :asc)
  end

  def moon
    cookies[:_bookmarkd_theme] = 'dark'
    redirect_to request.referer
  end

  def sun
    cookies[:_bookmarkd_theme] = 'light'
    redirect_to request.referer
  end

  def user_has_access_to_folder?
    @folder.open?
  end

  def folder_belongs_to_user?
    user_signed_in? && current_user.id == @folder.user_id
  end

  def can_access_folder?
    folder_belongs_to_user? || user_has_access_to_folder?
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name terms username])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[name order_folders_by username])
  end
end
