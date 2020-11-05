module FoldersHelper
  def folder_belongs_to_user(folder)
    folder.user == current_user
  end

  def is_pinned(folder)
    folder.pinned?
  end

  def folder_description(description)
    "#{description.truncate(70)} ·" unless description.blank?  
  end
end
