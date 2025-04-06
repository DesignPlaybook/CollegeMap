class Institute < ApplicationRecord
  has_many :institute_departments
  has_many :departments, through: :institute_departments
  validates :name, presence: true
  # validates :address, presence: true

  def self.import_institutes(params)
    Rails.logger.level = Logger::DEBUG
    begin
      ActiveRecord::Base.transaction do
      Rails.logger.info "Starting import of institutes"
      params.each do |institute_data|
        Rails.logger.info "Processing institute: #{institute_data[:name]}"
        institute = Institute.find_or_initialize_by(slug: institute_data[:slug])
        institute.assign_attributes(
        name: institute_data[:name],
        # address: institute_data[:address],
        )
        institute.save!
        Rails.logger.info "Saved institute: #{institute.name}"

        institute_data[:departments].each do |department_data|
        Rails.logger.info "Processing department: #{department_data[:name]}"
        department = Department.find_or_initialize_by(slug: department_data[:slug])
        department.name = department_data[:name]
        department.save!
        Rails.logger.info "Saved department: #{department.name}"

        institute_department = InstituteDepartment.find_or_initialize_by(
          institute: institute,
          department: department,
          gender: department_data[:gender],
          category_slug: department_data[:category_slug]
        )
        institute_department.assign_attributes(
          placement_score: department_data[:placement_score],
          higher_studies_score: department_data[:higher_studies_score],
          academics_experience_score: department_data[:academics_experience_score],
          entrepreneurship_score: department_data[:entrepreneurship_score],
          campus_score: department_data[:campus_score],
          category_slug: department_data[:category_slug],
          gender: department_data[:gender],
          closing_rank: department_data[:closing_rank],
          course_length: department_data[:course_length]
        )
        institute_department.save!
        Rails.logger.info "Saved institute_department for institute: #{institute.name}, department: #{department.name}"
        end
      end
      Rails.logger.info "Finished importing institutes"
      end
      "Institutes imported successfully"
    # rescue ActiveRecord::RecordInvalid => e
    #   Rails.logger.error "Validation failed: #{e.message}"
    #   "Validation failed: #{e.message}"
    # rescue => e
    #   Rails.logger.error "Error importing institutes: #{e.message}"
    #   "Error importing institutes: #{e.message}"
    end
  end
end
