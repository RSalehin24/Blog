class CreateTableCategories < ActiveRecord::Migration[7.0]
  def change
    create_table :categories do |t|
      t.string :name, unique: true

      t.timestamps
    end
  end
end