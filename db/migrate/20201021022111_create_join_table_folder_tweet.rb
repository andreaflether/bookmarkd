class CreateJoinTableFolderTweet < ActiveRecord::Migration[5.2]
  def change
    create_join_table :folders, :tweets do |t|
      # t.index [:folder_id, :tweet_id]
      # t.index [:tweet_id, :folder_id]
    end
  end
end
