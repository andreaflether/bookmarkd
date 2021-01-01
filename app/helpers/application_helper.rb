module ApplicationHelper
  def custom_flash_messages
    flash_messages = []

    # Overall flash messages
    flash.each do |type, message|
      type = 'success' if type == 'notice'
      type = 'error'   if type == 'alert'
      type = 'info'    if type == 'info'
      text = "
      <script>
        $(document).ready(function(){
          toastr.#{type}('#{message}');
        });
      </script>
      "
      flash_messages << text.html_safe
    end
    flash_messages.join("\n").html_safe
  end

  def title
    if content_for?(:title)
      # allows the title to be set in the view by using t(".title")
      page_title = content_for(:title)
    else
      page_title = t("#{ controller_path.tr('/', '.') }.#{ action_name }")
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
    link_to display_text, order_folders_by_path(params: { order_folders_by: sort_by}), 
    data: { 'sort-by': sort_by },
    method: :put, 
    remote: true,
    class: 'btn'
  end
end
