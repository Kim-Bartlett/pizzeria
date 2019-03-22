class AddOrderToPizza < ActiveRecord::Migration[5.2]
  def change
    add_reference :pizzas, :order, index: true
    add_foreign_key :pizzas, :orders
  end
end
