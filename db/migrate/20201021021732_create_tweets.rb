class CreateTweets < ActiveRecord::Migration[5.2]
  def change
    create_table :tweets do |t|
      t.string :link
      t.text :html_content

      t.timestamps
    end
  end
end
