# frozen_string_literal: true

class AddPrivacyToFolders < ActiveRecord::Migration[5.2]
  def change
    add_column :folders, :privacy, :integer, default: 1 # Private (Secret)
  end
end
