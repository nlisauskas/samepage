class AddStripeUidToContractors < ActiveRecord::Migration[5.2]
  def change
    add_column :contractors, :stripe_uid, :string
  end
end
