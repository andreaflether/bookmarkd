class CreateJoinTableFolderTweet < ActiveRecord::Migration[5.2]
  def change
    create_join_table :folders, :tweets do |t|
      # t.index [:folder_id, :tweet_id]
    end
    add_index :folders_tweets, [:tweet_id, :folder_id], unique: true
    add_index :folders_tweets, :tweet_id
  end
end
