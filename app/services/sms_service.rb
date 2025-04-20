require 'net/http'
require 'uri'
require 'json'

class SmsService
  SMS_API_URL = "https://www.fast2sms.com/dev/custom".freeze
  SMS_ROUTE = "dlt".freeze
  SENDER_ID = "DLT_SENDER_ID".freeze
  MESSAGE_ID = "YOUR_MESSAGE_ID".freeze

  def self.send_message(mobile_number, message)
    begin
      log_message_details(mobile_number, message)
      response = send_sms_request(mobile_number, message)
      handle_response(response)
    rescue StandardError => e
      puts "Error sending SMS: #{e.message}"
    end
  end

  private

  def self.log_message_details(mobile_number, message)
    puts "Sending SMS to: #{mobile_number}, Message: #{message}"
  end

  def self.send_sms_request(mobile_number, message)
    uri = URI.parse(SMS_API_URL)
    header = {
      'authorization': ENV["SMS_API_KEY"],
      'Content-Type': 'application/json'
    }
    payload = build_payload(mobile_number, message)

    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    request = Net::HTTP::Post.new(uri.request_uri, header)
    request.body = payload.to_json

    http.request(request)
  end

  def self.build_payload(mobile_number, message)
    {
      "route": SMS_ROUTE,
      "requests": [
        {
          "sender_id": SENDER_ID,
          "message": MESSAGE_ID,
          "variables_values": message,
          "flash": 0,
          "numbers": mobile_number.to_s
        }
      ]
    }
  end

  def self.handle_response(response)
    if response.is_a?(Net::HTTPSuccess)
      puts "SMS sent successfully: #{response.body}"
    else
      puts "Failed to send SMS: #{response.code} - #{response.message}"
    end
  end
end
