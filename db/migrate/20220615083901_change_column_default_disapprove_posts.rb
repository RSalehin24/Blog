class ChangeColumnDefaultDisapprovePosts < ActiveRecord::Migration[7.0]
  def change
    change_column_default :posts, :disapprove, from: nil, to: false
  end
end
