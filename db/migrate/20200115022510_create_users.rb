class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :gender
      t.datetime :birthdate
      t.string :password_digest
      t.string :email
      t.integer :property_id
      t.integer :tenant_id

      t.timestamps
    end
  end
end
