class PizzaTopping < ApplicationRecord
  include ActionView::Helpers::NumberHelper

  belongs_to :pizza
  belongs_to :topping

  validates :pizza_id, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0, less_than: 1000000 }
  validates :topping_id, presence: true

  def formatted_price
    number_to_currency(total_price, unit: '$')
  end
end
