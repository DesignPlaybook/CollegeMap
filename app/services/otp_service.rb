class OtpService
    require 'securerandom'

  # Generate a 6-digit OTP
  def self.generate_otp
    rand(1000..9999).to_s
  end

  # Send OTP via SMS (Replace with actual SMS provider API)
  def self.send_otp(mobile_number, otp)
    # Example: Integrate with Fast2SMS, Textlocal, Twilio, etc.
    SmsService.send_message(mobile_number, "Your #{ENV["SITE_TITLE"]} OTP is: #{otp}")
  end

  # Validate OTP expiration (e.g., 5 min validity)
  def self.otp_expired?(user)
    return true if user.otp_sent_at.nil?
    
    user.otp_sent_at < 5.minutes.ago
  end
end