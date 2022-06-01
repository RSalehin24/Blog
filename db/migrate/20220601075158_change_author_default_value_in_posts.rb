class ChangeAuthorDefaultValueInPosts < ActiveRecord::Migration[7.0]
  def change
    change_column_default :posts, :author, ''
  end
end
