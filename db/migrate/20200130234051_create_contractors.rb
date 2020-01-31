class CreateContractors < ActiveRecord::Migration[5.2]
  def change
    create_table :contractors do |t|
      t.string :first_name
      t.string :last_name
      t.string :company
      t.string :email
      t.string :password_digest
      t.integer :maintenance_request_id
      t.string :phone

      t.timestamps
    end
  end
end
