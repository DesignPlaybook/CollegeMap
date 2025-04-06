class CreateInstitute < ActiveRecord::Migration[7.2]
  def change
    create_table :institutes do |t|
      t.string :name
      t.string :slug
      t.timestamps
    end

    add_index :institutes, :slug, unique: true
  end
end
