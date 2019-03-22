class CustomerAddress < ApplicationRecord
  belongs_to :address
  belongs_to :customer

  validates :address_id, presence: true
  validates :customer_id, presence: true
end
