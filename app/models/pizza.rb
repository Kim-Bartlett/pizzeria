class Pizza < ApplicationRecord
  include ActionView::Helpers::NumberHelper
  # should this be a before save or something else to deal with timing issues?
  before_save :save_prices!
  after_save :update_order_price!

  belongs_to :order
  belongs_to :specialty_type

  has_many :pizza_toppings
  has_many :toppings, through: :pizza_toppings

  validates :specialty_type_id, presence: true
  validates :specialty_type_price, presence: true, numericality: { greater_than_or_equal_to: 0, less_than: 1000000 }
  validates :total_price, presence: true, numericality: { greater_than_or_equal_to: 0, less_than: 1000000 }

  def formatted_total_price
    number_to_currency(total_price, unit: '$')
  end

  def formatted_specialty_type_price
    number_to_currency(total_price, unit: '$')
  end

  def update_order_price!
    order.update_price!
  end

  def save_prices!
    specialty_type_price = specialty_type.price
    total_price = specialty_type.price + toppings.map(&:price).sum
  end

  def add_toppings_price!
    self.update_attributes(total_price: specialty_type.price + toppings.map(&:price).sum)
  end
end
