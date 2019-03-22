class Order < ApplicationRecord
  include ActionView::Helpers::NumberHelper

  belongs_to :address, optional: true
  belongs_to :customer

  has_many :pizzas
  has_many :toppings, through: :pizzas

  validates :address_id, presence: true, if: :delivery
  validates :customer_id, presence: true
  validates :status, presence: true
  validates :total_price, presence: true, numericality: { greater_than_or_equal_to: 0, less_than: 1000000 }

  enum status: {
      placed: 0,
      preparing: 1,
      delivering: 2,
      ready_for_pickup: 3,
      complete: 4,
      cancelled: 5
  }, _prefix: :order

  def formatted_total_price
    number_to_currency(total_price, unit: '$')
  end

  def to_json
    {
      order: {
        id: id,
        customer_name: customer.full_name,
        address: address.formatted_full,
        date: created_at.strftime('%a %b %-d %Y'),
        time: created_at.strftime('%I:%M%P'),
        status: status.titleize,
        total_price: formatted_total_price,
        pizzas: pizzas.map { |pizza| "#{pizza.specialty_type.name} with #{pizza.toppings.map(&:name)}" }
      }
    }
  end

  def update_price!
    self.update_attributes(total_price: pizzas.map(&:total_price).sum)
  end
end
