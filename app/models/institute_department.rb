class InstituteDepartment < ApplicationRecord
  belongs_to :institute
  belongs_to :department

  validates :institute_id, presence: true
  validates :department_id, presence: true

  COLUMN_MAPPINGS = {
    "placement_score" => "placement_score",
    "higher_studies_score" => "higher_studies_score",
    "academics_experience_score" => "academics_experience_score",
    "campus_score" => "campus_score",
    "entrepreneurship_score" => "entrepreneurship_score",
    "closing_rank" => "closing_rank",
    "course_length" => "course_length"
  }
end