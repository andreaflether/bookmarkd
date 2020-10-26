module FoldersHelper
  def folder_belongs_to_user(folder)
    folder.user == current_user
  end
end
