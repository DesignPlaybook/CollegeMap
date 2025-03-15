class SessionsController < ApplicationController
  SECRET_KEY = Rails.application.secret_key_base

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
      user.update(otp: nil) # Clear OTP after successful login

      # Store JWT in HTTP-Only, Secure Cookie
      cookies.signed[:jwt] = {
        value: token,
        httponly: true,   # Prevent JS from accessing it
        secure: Rails.env.production?, # Secure cookies are only used in production to ensure they are transmitted over HTTPS, enhancing security.
        same_site: :strict, # Prevent CSRF attacks by setting the SameSite attribute to Strict
        expires: 24.hours.from_now
      }
      render json: { message: "Login successful" }
    else
      if user&.otp_sent_at.present? && user.otp_sent_at <= 5.minutes.ago
        render json: { error: "OTP has expired. Please request a new one." }, status: :unauthorized
      else
        render json: { error: "Incorrect OTP. Please try again." }, status: :unauthorized
      end
    end
  end

  def destroy
    cookies.delete(:jwt) # Clear JWT cookie on logout
    render json: { message: "Logged out successfully" }
  end

  private

  def generate_jwt(user)
    payload = { user_id: user.id, mobile_number: user.mobile_number, exp: 24.hours.from_now.to_i }
    JWT.encode(payload, SECRET_KEY, "HS256")
  end
end
