class CreateCategory < ActiveRecord::Migration[7.2]
  def change
    create_table :categories do |t|
      t.string :name
      t.string :slug
      t.timestamps
    end
    add_index :categories, :slug, unique: true
  end
end
