class Pizza < ApplicationRecord
  include ActionView::Helpers::NumberHelper
  after_create :update_price!

  belongs_to :order
  belongs_to :specialty_type

  has_many :pizza_toppings
  has_many :toppings, through: :pizza_toppings

  validates :specialty_type_id, presence: true
  validates :specialty_type_price, presence: true, numericality: { greater_than_or_equal_to: 0, less_than: 1000000 }

  def self.create_pizza!(quantity, order_id, type_id, topping_ids)
    quantity.to_i.times do
      new_pizza = Pizza.create!(order_id: order_id, specialty_type_id: type_id)
      topping_ids.each do |id|
        PizzaTopping.create!(pizza: new_pizza, topping_id: id)
      end
    end
  end

  def formatted_total_price
    number_to_currency(total_price, unit: '$')
  end

  def formatted_specialty_type_price
    number_to_currency(specialty_type_price, unit: '$')
  end

  def total_price
    specialty_type.price + pizza_toppings.map(&:price).sum
  end

  def update_price!
    self.update!(specialty_type_price: specialty_type.price)
  end
end
