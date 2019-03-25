class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.references :address, index: true
      t.references :customer, index: true
      t.integer :status, optional: false, default: 0
      t.boolean :delivery, optional: false, default: true

      t.timestamps
    end

    add_foreign_key :orders, :addresses
    add_foreign_key :orders, :customers
  end
end
