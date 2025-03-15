class InstituteDepartments < ActiveRecord::Migration[7.2]
  def change
    create_table :institute_departments do |t|
      t.references :institute, null: false, foreign_key: true
      t.references :department, null: false, foreign_key: true

      t.timestamps
    end
  end
end
