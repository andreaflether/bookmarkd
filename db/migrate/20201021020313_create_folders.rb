# frozen_string_literal: true

class CreateFolders < ActiveRecord::Migration[5.2]
  def change
    create_table :folders do |t|
      t.belongs_to :user
      t.string :name
      t.text :description
      t.boolean :pinned, default: false

      t.timestamps
    end
  end
end
