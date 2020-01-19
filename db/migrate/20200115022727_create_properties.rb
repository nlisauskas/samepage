class CreateProperties < ActiveRecord::Migration[5.2]
  def change
    create_table :properties do |t|
      t.string :street_1
      t.string :street_2
      t.string :city
      t.string :state
      t.integer :zipcode
      t.integer :user_id
      t.integer :tenant_id
      t.datetime :purchase_date
      t.datetime :sale_date
      t.float :purchase_price
      t.float :sale_price

      t.timestamps
    end
  end
end
