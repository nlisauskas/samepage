class AddPaymentIntentToBids < ActiveRecord::Migration[5.2]
  def change
    add_column :bids, :payment_intent, :string
  end
end
