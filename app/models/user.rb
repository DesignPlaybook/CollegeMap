class User < ApplicationRecord

  def exceeded_otp_limit?
    max_otp_attempts = ENV["OTP_ATTEMPTS_LIMIT"]&.to_i
    return false unless max_otp_attempts && otp_sent_at

    otp_attempts >= max_otp_attempts && otp_sent_at > 24.hours.ago
  end
end
