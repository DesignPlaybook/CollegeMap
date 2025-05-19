class CreatePaymentOrders < ActiveRecord::Migration[7.2]
  def change
    create_table :payment_orders do |t|
      t.references :user, null: false
      t.string :razorpay_order_id, index: true, null: false
      t.integer :amount
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
