class CreateMaintenanceRequests < ActiveRecord::Migration[5.2]
  def change
    create_table :maintenance_requests do |t|
      t.string :category
      t.string :description
      t.string :title
      t.integer :property_id
      t.integer :tenant_id
      t.integer :user_id

      t.timestamps
    end
  end
end
