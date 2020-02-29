class ChangePriceToBeIntegerInBids < ActiveRecord::Migration[5.2]
  def change
      change_column :bids, :price, :integer
      change_column :bids, :payout, :integer
  end
end
