class CreateDepartment < ActiveRecord::Migration[7.2]
  def change
    create_table :departments do |t|
      t.string :name
      t.string :slug
      t.timestamps
    end

    add_index :departments, :slug, unique: true
  end
end
