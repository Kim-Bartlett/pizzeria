class CreatePizzaToppings < ActiveRecord::Migration[5.2]
  def change
    create_table :pizza_toppings do |t|
      t.references :pizza, index: true
      t.references :topping, index: true
      t.decimal :price, precision: 8, scale: 2, optional: false, default: 0.00

      t.timestamps
    end

    add_foreign_key :pizza_toppings, :pizzas
    add_foreign_key :pizza_toppings, :toppings
  end
end
