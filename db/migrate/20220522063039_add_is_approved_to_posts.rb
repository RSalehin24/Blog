class AddIsApprovedToPosts < ActiveRecord::Migration[7.0]
  def change
    add_column :posts, :is_approved, :boolean
  end
end
