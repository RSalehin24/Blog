class AddIsRequestedToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :is_requested, :boolean
  end
end
