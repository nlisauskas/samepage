class CreateBids < ActiveRecord::Migration[5.2]
  def change
    create_table :bids do |t|
      t.decimal :price
      t.decimal :payout
      t.string :availability
      t.string :notes
      t.integer :maintenance_request_id
      t.integer :contractor_id
      t.boolean :approved, :default => false

      t.timestamps
    end
  end
end
