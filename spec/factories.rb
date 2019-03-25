FactoryBot.define do
  factory :address do
    sequence(:city) { 'Pittsburgh' }
    sequence(:state) { 'PA' }
    sequence(:street) { |n| "#{n} Lala Lane" }
    sequence(:zip) { |n| "5555#{n}" }
  end

  factory :customer do
    sequence(:email) { |n| "email#{n}@gmail.com" }
    sequence(:first_name) { |n| "first#{n}" }
    sequence(:last_name) { |n| "first#{n}" }
    sequence(:phone) { |n| "555-555-555#{n}" }

    after :create do |customer|
      create_list :customer_address, 2, customer: customer
      create_list :order, 3, customer: customer
    end
  end

  factory :customer_address do
    association :address, factory: :address
    association :customer, factory: :customer
  end

  factory :order do
    status { 0 }

    association :address, factory: :address
    association :customer, factory: :customer
  end

  factory :pizza do
    association :order, factory: :order
    association :specialty_type, factory: :specialty_type

    after :create do |pizza|
      create_list :pizza_topping, 3, pizza: pizza
    end
  end

  factory :pizza_topping do
    association :pizza, factory: :pizza
    association :topping, factory: :topping
  end

  factory :specialty_type do
    sequence(:name) { |n| "specialty#{n}" }
    price { 9.99 }
  end

  factory :topping do
    sequence(:name) { |n| "specialty#{n}" }
    price { 0.50 }
  end
end
