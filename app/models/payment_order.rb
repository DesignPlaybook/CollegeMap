class PaymentOrder < ApplicationRecord
  belongs_to :user
  enum status: { created: 0, received: 1, failed: 2 }

  def amount_in_inr
    amount / 100.0
  end
end
