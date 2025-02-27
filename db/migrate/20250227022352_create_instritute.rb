class CreateInstritute < ActiveRecord::Migration[7.2]
  def change
    create_table :institutes do |t|
      t.string :name
      t.string :address
      t.timestamps
    end
  end
end
