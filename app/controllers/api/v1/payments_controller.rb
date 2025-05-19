class Api::V1::PaymentsController < ApplicationController
  before_action :authenticate_user
  def create_order
    amount = ENV["AMOUNT"]
    order = Razorpay::Order.create(
      amount: amount,
      currency: 'INR',
      receipt: "receipt_#{current_user.id}_#{SecureRandom.hex(5)}",
      payment_capture: 1
    )

    # Save locally
    PaymentOrder.create!(
      user_id: current_user.id,
      razorpay_order_id: order.id,
      amount: amount)

    render json: { order_id: order.id, amount: amount, key: ENV['RAZORPAY_KEY_ID'] }
  end

  def verify
    payment_id = params[:razorpay_payment_id]
    order_id = params[:razorpay_order_id]
    signature = params[:razorpay_signature]

    generated_signature = OpenSSL::HMAC.hexdigest(
      'SHA256',
      ENV['RAZORPAY_KEY_SECRET'],
      "#{order_id}|#{payment_id}"
    )

    payment_order = PaymentOrder.find_by(razorpay_order_id: order_id)
    if ActiveSupport::SecurityUtils.secure_compare(generated_signature, signature)
      payment_order.update(status: :received)
      payment_order.user.update(balance: payment_order.user.balance + payment_order.amount)
      render json: { success: true }
    else
      payment_order.update(status: :failed)
      render json: { success: false }, status: 400
    end
  end
end
