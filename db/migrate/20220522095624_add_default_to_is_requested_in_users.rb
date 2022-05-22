class AddDefaultToIsRequestedInUsers < ActiveRecord::Migration[7.0]
  def change
    change_column_default :users, :is_requested, false
  end
end
