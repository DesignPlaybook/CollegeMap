class InstituteDepartments < ActiveRecord::Migration[7.2]
  def change
    create_table :institute_departments do |t|
      t.integer :institute_id, index: true
      t.integer :department_id, index: true
      t.float :placement_score
      t.float :higher_studies_score
      t.float :academics_experience_score
      t.float :campus_score
      t.float :entrepreneurship_score
      t.string :category_slug, index: true
      t.string :gender, index: true
      t.integer :closing_rank, index: true
      t.float :course_length

      t.timestamps
    end
  end
end
