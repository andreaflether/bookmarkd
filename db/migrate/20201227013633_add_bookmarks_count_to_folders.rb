class AddBookmarksCountToFolders < ActiveRecord::Migration[5.2]
  def change
    add_column :folders, :bookmarks_count, :integer
  end
end
