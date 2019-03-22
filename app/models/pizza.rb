class Pizza < ApplicationRecord
  include ActionView::Helpers::NumberHelper

  belongs_to :order
  belongs_to :specialty_type

  has_many :pizza_toppings
  has_many :toppings, through: :pizza_toppings

  # accepts_nested_attributes_for :pizza_toppings

  validates :specialty_type_id, presence: true
  validates :specialty_type_price, presence: true, numericality: { greater_than_or_equal_to: 0, less_than: 1000000 }
  validates :total_price, presence: true, numericality: { greater_than_or_equal_to: 0, less_than: 1000000 }

  def formatted_total_price
    number_to_currency(total_price, unit: '$')
  end

  def formatted_specialty_type_price
    number_to_currency(total_price, unit: '$')
  end
end
