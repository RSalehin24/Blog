class AddDefaultToIsApprovedInPosts < ActiveRecord::Migration[7.0]
  def change
    change_column_default :posts, :is_approved, false
  end
end
