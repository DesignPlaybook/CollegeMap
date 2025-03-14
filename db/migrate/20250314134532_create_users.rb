class CreateUsers < ActiveRecord::Migration[7.2]
  def change
    create_table :users do |t|
      t.string :mobile_number, null: false
      t.string :otp
      t.string :name
      t.integer :otp_attempts, default: 0
      t.datetime :otp_sent_at

      t.timestamps
    end
    add_index :users, :mobile_number
  end
end
