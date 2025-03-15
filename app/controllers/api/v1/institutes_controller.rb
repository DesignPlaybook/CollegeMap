class Api::V1::InstitutesController < ApplicationController
  def index
    @institutes = Institute.all
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