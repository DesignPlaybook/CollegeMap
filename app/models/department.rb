class Department < ApplicationRecord
  has_many :institutes, through: :institute_departments
  has_many :institute_departments
  validates :name, presence: true
end
