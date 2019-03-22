# 

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).

toppings_list = [
    ['Pepperoni', 1.00],
    ['Sausage', 1.00],
    ['Garlic', 0.50],
    ['Olives', 0.50],
    ['Mushrooms', 0.50],
    ['Onions', 0.50],
    ['Chicken', 1.00],
    ['Oregano', 0.50],
    ['Bacon', 1.00],
    ['Spinach', 0.50],
    ['Extra Cheese', 1.00],
    ['Green Peppers', 0.50],
]

types_list = [
    ['Thin Crust', 9.99],
    ['Regular', 9.99],
    ['Deep Dish', 11.99],
    ['Margherita', 11.99],
    ['White Pizza', 11.99]
]

toppings_list.each do |name, price|
  Topping.create( name: name, price: price)
end

types_list.each do |name, price|
  SpecialtyType.create( name: name, price: price)
end