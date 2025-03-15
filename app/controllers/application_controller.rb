class ApplicationController < ActionController::API
  SECRET_KEY = Rails.application.secret_key_base

  def authenticate_user
    token = cookies.signed[:jwt]
    decoded_token = JwtService.decode_token(token)

    if decoded_token && (user = User.find_by(id: decoded_token["user_id"], mobile_number: decoded_token["mobile_number"]))
      @current_user = user
    else
      render json: { error: "Unauthorized" }, status: :unauthorized
    end
  end
end
