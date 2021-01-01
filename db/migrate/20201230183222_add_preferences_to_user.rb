class AddPreferencesToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :preferences, :json
  end
end
