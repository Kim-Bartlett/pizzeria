class CreatePizza < ActiveRecord::Migration[5.2]
  def change
    create_table :pizzas do |t|
      t.references :specialty_type, index: true
      t.decimal :specialty_type_price, precision: 8, scale: 2, optional: false, default: 0.00

      t.timestamps
    end

    add_foreign_key :pizzas, :specialty_types
  end
end
