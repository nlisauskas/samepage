class AddContractorIdToMaintenanceRequests < ActiveRecord::Migration[5.2]
  def change
    add_column :maintenance_requests, :contractor_id, :integer
  end
end
