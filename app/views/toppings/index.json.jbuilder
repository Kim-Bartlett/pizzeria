json.key_format! camelize: :lower

json.toppings @toppings do |topping|
  json.(topping, :id, :name, :available)
  json.price topping.formatted_price
end
