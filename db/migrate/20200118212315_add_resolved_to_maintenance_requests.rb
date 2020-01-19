class AddResolvedToMaintenanceRequests < ActiveRecord::Migration[5.2]
  def change
    add_column :maintenance_requests, :resolved, :boolean
  end
end
