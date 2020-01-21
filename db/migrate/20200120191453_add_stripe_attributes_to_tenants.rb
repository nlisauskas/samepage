class AddStripeAttributesToTenants < ActiveRecord::Migration[5.2]
  def change
    add_column :tenants, :stripe_uid, :string
  end
end
