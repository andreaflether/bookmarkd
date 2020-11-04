class CreateBookmarks < ActiveRecord::Migration[5.2]
  def change
    create_table :bookmarks do |t|
      t.belongs_to :folder, foreign_key: true
      t.belongs_to :tweet, foreign_key: true

      t.timestamps
    end
  end
end
