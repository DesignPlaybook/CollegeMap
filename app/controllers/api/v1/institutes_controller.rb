class Api::V1::InstitutesController < ApplicationController
  before_action :authenticate_user, only: [:enhanced_result]
  def index
    @institutes = Institute.includes(:departments).limit(5)
  end

  def primary_result
    @institutes = Institute.includes(:departments).limit(5)
  end

  def enhanced_result
    @institutes = Institute.includes(:departments)
  end

  def import_institutes
    if ENV["IMPORT_INSTITUTES_CREDS"] == params[:creds]
      message Institute.import_institutes(institute_params)
      render json: { message: message }
    else
      render json: { message: "Invalid credentials" }, status: :unauthorized
    end
  end

  private

  def institute_params
    params.require(:institute).permit(:name, :slug, :address, departments: [:name, :slug])
  end
end