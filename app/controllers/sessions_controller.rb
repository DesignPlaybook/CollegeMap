class SessionsController < ApplicationController
  SECRET_KEY = Rails.application.secret_key_base
  before_action :authenticate_user, only: [:show]

  def send_verification_code
    user = User.find_or_create_by(mobile_number: params[:mobile_number])
    if user.exceeded_otp_limit?
      return render json: { error: "Exceeded OTP limit. Try again after 24 hours" }, status: :too_many_requests
    end

    if user.otp_sent_at.present? && user.otp_sent_at > 2.minute.ago
      return render json: { error: "OTP already sent. Please wait for 2 minutes before requesting a new one." }, status: :too_many_requests
    end

    otp = OtpService.generate_otp
    
    OtpService.send_otp(user.mobile_number, otp)
    if user.update(otp: otp, otp_sent_at: Time.current, otp_attempts: user.otp_attempts + 1)
      render json: { message: "OTP sent successfully" }
    else
      render json: { error: "Failed to update OTP. Please try again." }, status: :unprocessable_entity
    end
  end

  def create
    user = User.find_by(mobile_number: params[:mobile_number])

    if user&.otp == params[:otp].to_s && user.otp_sent_at.present? && user.otp_sent_at > 5.minutes.ago
      token = generate_jwt(user)
      user.update(otp: nil, otp_attempts: 0) # Clear OTP after successful login

      # Return JWT in JSON response
      render json: { message: "Login successful", token: token }
    else
      if user&.otp_sent_at.present? && user.otp_sent_at <= 5.minutes.ago
        render json: { error: "OTP has expired. Please request a new one." }, status: :unauthorized
      else
        render json: { error: "Incorrect OTP. Please try again." }, status: :unauthorized
      end
    end
  end

  def destroy
    # Inform the client to remove the token from local storage
    render json: { message: "Logged out successfully. Please remove the token from local storage." }
  end

  def show
    render json: {
      user: {
        id: @current_user.id,
        mobile_number: @current_user.mobile_number
      }
    }
  end

  private

  def generate_jwt(user)
    payload = { user_id: user.id, mobile_number: user.mobile_number, exp: 24.hours.from_now.to_i }
    JWT.encode(payload, SECRET_KEY, "HS256")
  end
end
