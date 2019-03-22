json.key_format! camelize: :lower

json.specialty_types @specialty_types do |specialty_type|
  json.(specialty_type, :id, :name, :available)
  json.price specialty_type.formatted_price
end
