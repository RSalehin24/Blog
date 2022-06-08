class CreateCommentReplies < ActiveRecord::Migration[7.0]
  def change
    create_table :comment_replies do |t|
      t.string :replier
      t.text :reply
      t.references :comment, null: false, foreign_key: true

      t.timestamps
    end
  end
end
