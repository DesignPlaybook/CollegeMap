class Institute < ApplicationRecord
  has_many :institute_departments
  has_many :departments, through: :institute_departments
  validates :name, presence: true
  validates :address, presence: true

  def self.import_institutes(params)
    params[:institutes].each do |institute_data|
      institute = Institute.find_or_initialize_by(slug: institute_data[:slug])
      institute.name = institute_data[:name]
      institute.address = institute_data[:address]
      institute.save!

      institute_data[:departments].each do |department_data|
        department = Department.find_or_initialize_by(slug: department_data[:slug])
        department.name = department_data[:name]
        department.save!
        InstituteDepartment.find_or_create_by(institute: institute, department: department)
      end
    end
    "Institutes imported successfully"
  end
end
