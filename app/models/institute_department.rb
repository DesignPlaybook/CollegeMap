class InstituteDepartment < ApplicationRecord
  belongs_to :institute
  belongs_to :department
  belongs_to :category

  validates :institute_id, presence: true
  validates :department_id, presence: true

  validates_uniqueness_of :institute_id, scope: :department_id
end