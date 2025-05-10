class InstituteDepartment < ApplicationRecord
  belongs_to :institute
  belongs_to :department

  validates :institute_id, presence: true
  validates :department_id, presence: true
  SCORE_KEYS = %w(placement_score higher_studies_score
                  academics_experience_score campus_score
                  entrepreneurship_score).freeze

  # Fetch eligible institutes based on gender, category, and rank
  def self.eligible_institutes(params)
    query = where(gender: params[:gender], category_slug: params[:category])
            .where("closing_rank >= ?", params[:rank])

    query = query.where(course_length: params[:course_duration]) if params[:course_duration].present?
    query
  end

  # Fetches and ranks institutes based on the given parameters and weights
  def self.fetch_institutes(result = {}, params = {}, primary_result = false)
    eligible_departments = eligible_institutes(params)
    return [] if eligible_departments.empty?

    scored_departments = calculate_scores(eligible_departments, result[:weights])

    institute_departments = primary_result ? fetch_primary_results(scored_departments, result[:weights]) : fetch_secondary_results(scored_departments, eligible_departments, params)
    ordered_result = order_by_weight(institute_departments, result[:weights])
  end

  private

  # Calculate weighted scores for each department
  def self.calculate_scores(eligible_departments, weights)
    eligible_departments
      .select(:id, :institute_id, :placement_score, :higher_studies_score,
              :academics_experience_score, :campus_score, :entrepreneurship_score)
      .as_json
      .each do |department|
        department.each do |key, value|
          next if key == "id" || key == "institute_id"
          weight = weights[key.to_sym]
          department[key] = value * weight unless weight.nil?
        end
        department[:total_score] = department.except("id, institute_id").values.sum
      end
  end

  # Fetch primary results (top 5 departments)
  def self.fetch_primary_results(scored_departments)
    top_departments = scored_departments.sort_by { |dept| -dept[:total_score] }.first(5)
    InstituteDepartment
      .where(id: top_departments.map { |dept| dept["id"] })
      .joins(:institute, :department)
      .select("institutes.name AS institute_name, departments.name AS department_name")
      .select(:id, :institute_id, :placement_score, :higher_studies_score,
              :academics_experience_score, :campus_score, :entrepreneurship_score)
      .limit(5)
  end

  # Fetch secondary results (top 25 departments with preferences)
  def self.fetch_secondary_results(scored_departments, eligible_departments, params)
    preferred_ids = fetch_preferred_ids(eligible_departments, params)
    remaining_count = 25 - preferred_ids.size

    unless preferred_ids.empty?
      scored_departments.reject! { |dept| preferred_ids.include?(dept["id"]) }
    end

    top_department_ids = if remaining_count > 0
                           scored_departments.sort_by { |dept| -dept[:total_score] }
                                             .first(remaining_count)
                                             .map { |dept| dept["id"] } + preferred_ids
                         else
                           preferred_ids
                         end

    InstituteDepartment
      .where(id: top_department_ids)
      .joins(:institute, :department)
      .select("institutes.name AS institute_name, departments.name AS department_name")
      .select(:id, :institute_id, :placement_score, :higher_studies_score,
              :academics_experience_score, :campus_score, :entrepreneurship_score)
      .limit(25)

  end

  # Fetch preferred institute department IDs
  def self.fetch_preferred_ids(eligible_departments, params)
    return [] unless params[:preffered_institute_ids].present?

    eligible_departments
      .where(institute_id: params[:preffered_institute_ids])
      .ids
  end

  def self.generate_csv(institute_departments)
    CSV.generate(headers: true) do |csv|
      csv << ["Institute Name", "Department Name"]
      institute_departments.each do |institute_department|
        csv << [institute_department['institute_name'], institute_department['department_name']]
      end
    end
  end

  def self.create_csv(institute_departments)
    return unless institute_departments.present?

    # Generate CSV content
    csv_content = generate_csv(institute_departments)

    # Save the CSV to a file
    save_csv_to_file(csv_content)
  end

  def self.save_csv_to_file(csv_content)
    # Create a unique filename with timestamp and UUID
    filename = "institute_departments_#{Time.now.strftime('%Y%m%d%H%M%S')}_#{SecureRandom.uuid}.csv"
    dir_path = Rails.root.join("public", "csvs")
    FileUtils.mkdir_p(dir_path) unless File.directory?(dir_path)
  
    file_path = dir_path.join(filename)
    
    File.write(file_path, csv_content)
  
    file_url = "#{ENV['BASE_URL']}/csvs/#{filename}"
  end

  def self.order_by_weight(institute_departments, weights)
    institute_departments = institute_departments.as_json
    institute_departments.each do |department|
      total_score = 0
      department.each do |key, value|
        next unless SCORE_KEYS.include?(key)
        weight = weights[key.to_sym]
        v = value
        v =  value * weight unless weight.nil?
        total_score += v
      end
      department[:total_score] = total_score
    end

    institute_departments.sort_by { |dept| -dept[:total_score] }
  end
end