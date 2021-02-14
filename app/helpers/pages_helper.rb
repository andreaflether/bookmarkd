# frozen_string_literal: true

module PagesHelper
  def not_edit_user_registration_path
    controller_name == 'registrations' && %w[edit update].include?(action_name)
  end
end
