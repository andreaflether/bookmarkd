# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :pinned_folders, if: :user_signed_in?
  helper_method :generate_verification_keyword, :user_has_access_to_folder?, :folder_belongs_to_user?,
                :can_access_folder?
  before_action :generate_verification_keyword, if: :is_registration_path?

  def is_registration_path?
    devise_controller? && %w[edit update].include?(action_name)
  end

  def pinned_folders
    @pinned = current_user.pinned_folders.order(name: :asc)
  end

  def moon
    cookies.delete(:sun)
    redirect_to request.referer
  end

  def sun
    cookies[:sun] = { value: 'light mode on' }
    redirect_to request.referer
  end

  def generate_verification_keyword
    @keyword_confirmation = Faker::Internet.slug
  end

  def user_has_access_to_folder?
    !@folder.secret?
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
