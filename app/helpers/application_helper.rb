# frozen_string_literal: true

module ApplicationHelper
  def custom_flash_messages
    html_script = '<script>'
    flash.each do |type, message|
      html_script += "toastr[\"#{toastr_class_for(type)}\"](\"#{message}\");" if message
    end
    html_script += '</script>'
    flash_present = flash.to_h.any?
    flash.clear
    flash_present ? html_script.html_safe : ''
  end

  def toastr_class_for(flash_type)
    type = {
      success: 'success',
      error: 'error',
      alert: 'warning',
      notice: 'info'
    }

    type[flash_type.to_sym]
  end

  def title
    page_title = if content_for?(:title)
                   # allows the title to be set in the view by using t(".title")
                   content_for(:title)
                 else
                   t("#{controller_path.tr('/', '.')}.#{action_name}")
                 end
    page_title.include?('translation_missing') ? t(:site_name) : "#{page_title} / #{t(:site_name)}"
  end

  def light_mode?
    cookies[:sun]
  end

  def application_mode
    light_mode? ? 'light' : 'dark'
  end

  def sort_by_template(display_text, sort_by)
    link_to display_text, order_folders_by_path(params: { order_folders_by: sort_by }),
            data: {
              'sort-by': sort_by,
              'tippy-content': "Sort folders by #{t("content.sort_by.#{sort_by}")}",
              'tippy-placement': 'bottom'
            },
            method: :put,
            remote: true,
            class: 'btn'
  end
end
