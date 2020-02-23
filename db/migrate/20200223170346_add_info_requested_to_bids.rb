class AddInfoRequestedToBids < ActiveRecord::Migration[5.2]
  def change
    add_column :bids, :info_requested, :boolean, default: false
  end
end
