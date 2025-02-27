class Institute < ApplicationRecord
  has_many :departments, through: :institute_departments
  has_many :institute_departments
  validates :name, presence: true
  validates :address, presence: true
end