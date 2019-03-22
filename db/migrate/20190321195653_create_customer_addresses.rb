class CreateCustomerAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :customer_addresses do |t|
      t.references :customer, index: true
      t.references :address, index: true

      t.timestamps
    end

    add_foreign_key :customer_addresses, :customers
    add_foreign_key :customer_addresses, :addresses
  end
end
