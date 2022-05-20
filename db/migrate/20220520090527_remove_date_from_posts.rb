class RemoveDateFromPosts < ActiveRecord::Migration[7.0]
  def change
    remove_column :posts, :date, :datetime
  end
end
