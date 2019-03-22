class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.references :address, index: true
      t.references :customer, index: true
      t.decimal :total_price, precision: 8, scale: 2, optional: false, default: 0.00
      t.integer :status, optional: false, default: 0
      t.boolean :delivery, optional: false, default: true

      t.timestamps
    end

    add_foreign_key :orders, :addresses
    add_foreign_key :orders, :customers
  end
end
