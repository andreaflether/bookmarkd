class PopulateFolderBookmarksCount < ActiveRecord::Migration[5.2]
  def up
    Folder.find_each do |folder|
      Folder.reset_counters(folder.id, :bookmarks)
    end
  end
end