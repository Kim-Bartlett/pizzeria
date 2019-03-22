class SpecialtyType < ApplicationRecord
  include ActionView::Helpers::NumberHelper

  validates :available, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0, less_than: 1000000 }
  validates :name, presence: true

  def formatted_price
    number_to_currency(price, unit: '$')
  end
end
