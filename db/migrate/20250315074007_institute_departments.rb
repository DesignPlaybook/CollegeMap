class InstituteDepartments < ActiveRecord::Migration[7.2]
  def change
    create_table :institute_departments do |t|
      t.integer :institute_id, index: true
      t.integer :department_id, index: true

      t.timestamps
    end
  end
end
