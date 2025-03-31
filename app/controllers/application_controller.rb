class ApplicationController < ActionController::Base
  SECRET_KEY = Rails.application.secret_key_base

  def authenticate_user
    token = extract_token_from_header
    return unauthorized_response unless token

    @decoded_token = decode_token(token)
    return unauthorized_response unless @decoded_token

    @current_user = find_user_from_token(@decoded_token)
    return unauthorized_response unless @current_user
  end

  private

  def extract_token_from_header
    request.headers["Authorization"]&.split(" ")&.last
  end

  def decode_token(token)
    JWT.decode(token, SECRET_KEY, true, { algorithm: "HS256" }).first
  rescue JWT::DecodeError
    nil
  end

  def find_user_from_token(decoded_token)
    User.find_by(id: decoded_token["user_id"], mobile_number: decoded_token["mobile_number"])
  end

  def unauthorized_response
    render json: { error: "Unauthorized" }, status: :unauthorized
  end
end
