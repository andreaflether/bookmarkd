module FoldersHelper
  def folder_belongs_to_user(folder)
    folder.user == current_user
  end

  def is_pinned(folder)
    folder.pinned?
  end
end
