# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :pinned_folders, if: :user_signed_in?

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

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name terms username])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[name order_folders_by username])
  end
end
