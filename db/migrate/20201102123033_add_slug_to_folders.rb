# frozen_string_literal: true

class AddSlugToFolders < ActiveRecord::Migration[5.2]
  def change
    add_column :folders, :slug, :string
    add_index :folders, :slug, unique: true
  end
end
