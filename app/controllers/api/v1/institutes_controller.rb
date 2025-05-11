class Api::V1::InstitutesController < ApplicationController
  before_action :authenticate_user, only: [:enhanced_result, :check_consistancy]
  def index
    @institutes = Institute.includes(:departments).limit(5)
  end

  def check_eligibility
    @institutes = InstituteDepartment.eligible_institutes(params)
    if @institutes.empty?
      render json: { message: "No institutes found" }, status: :not_found
    else
      @institutes = @institutes.joins(:institute)
      .select("institutes.name AS institute_name, institutes.id AS institute_id")
      .distinct("institute_id")
      render json: { institutes: @institutes.as_json }, status: :ok
    end
  end

  def primary_result
    matrix_data = AhpMatrixBuilder.build_ahp_matrix(params, true)
    result = AhpCalculator.new(matrix_data[:criteria], matrix_data[:matrix]).result
    @institute_departments  = InstituteDepartment.fetch_institutes(result, params, true)
  end

  def enhanced_result
    matrix_data = AhpMatrixBuilder.build_ahp_matrix(params)
    result = AhpCalculator.new(matrix_data[:criteria], matrix_data[:matrix]).result
    @institute_departments = InstituteDepartment.fetch_institutes(result, params)
    @csv = InstituteDepartment.create_csv(@institute_departments)
  end

  def import_institutes
    if ENV["IMPORT_INSTITUTES_CREDS"] == params[:creds]
      message Institute.import_institutes(institute_params)
      render json: { message: message }
    else
      render json: { message: "Invalid credentials" }, status: :unauthorized
    end
  end

  def check_consistancy
    matrix_data = AhpMatrixBuilder.build_ahp_matrix(params)
    result = AhpCalculator.new(matrix_data[:criteria], matrix_data[:matrix]).result
    render json: { consistency_score: result.dig(:consistency, :consistency_score) }
  end

  private

  def institute_params
    params.require(:institute).permit(:name, :slug, :address, departments: [:name, :slug])
  end
end