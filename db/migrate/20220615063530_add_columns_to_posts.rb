class AddColumnsToPosts < ActiveRecord::Migration[7.0]
  def change
    add_column :posts, :disapprove, :boolean
    add_column :posts, :disapprove_count, :integer
    add_column :posts, :disapprove_message, :text
  end
end
