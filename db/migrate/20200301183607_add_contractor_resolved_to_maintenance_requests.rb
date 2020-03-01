class AddContractorResolvedToMaintenanceRequests < ActiveRecord::Migration[5.2]
  def change
    add_column :maintenance_requests, :contractor_resolved, :boolean, default: false
  end
end
