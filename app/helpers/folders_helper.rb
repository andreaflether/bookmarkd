module FoldersHelper
  def folder_belongs_to_user(folder)
    folder.user == current_user
  end

  def is_pinned(folder)
    folder.pinned?
  end

  def folder_description(description)
    description.truncate(70) unless description_blank?(description)
  end

  def description_blank?(description)
    description.blank?
  end

  def datetime_formatted(datetime)
    datetime.strftime("%B %d, %Y %H:%M")
  end
end
