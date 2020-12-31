module PagesHelper
  def not_edit_user_registration_path
    controller_name == 'registrations' && ['edit', 'update'].include?(action_name)
  end
end
