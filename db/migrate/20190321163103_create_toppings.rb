class CreateToppings < ActiveRecord::Migration[5.2]
  def change
    create_table :toppings do |t|
      t.string :name, optional: false
      t.decimal :price, precision: 8, scale: 2, optional: false, default: 0.00
      t.boolean :available, optional: false, default: true

      t.timestamps
    end
  end
end
