class Customer < ApplicationRecord
  has_many :customer_addresses
  has_many :addresses, through: :customer_addresses
  has_many :orders

  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP,
                                                                message: 'Please enter a valid email address.' }
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :phone, presence: true, format: { with: /\(?[0-9]{3}\)?-[0-9]{3}-[0-9]{4}/,
                                              message: 'Phone numbers must be in xxx-xxx-xxxx format.' }

  def full_name
    "#{first_name} #{last_name}".titleize
  end
end
