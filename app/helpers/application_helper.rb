module ApplicationHelper
  def custom_flash_messages
    flash_messages = []

    # Overall flash messages
    flash.each do |type, message|
      type = 'success' if type == 'notice'
      type = 'error'   if type == 'alert'
      type = 'info'    if type == 'info'
      text = "<script>$( document ).ready(function() {toastr.#{type}('#{message}');});</script>"
      flash_messages << text.html_safe
    end

    flash_messages.join("\n").html_safe
  end
end
