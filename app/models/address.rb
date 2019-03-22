class Address < ApplicationRecord
  before_save :downcase_fields

  validates :city, presence: true
  validates :state, presence: true
  validates :street, presence: true
  validates :zip, presence: true

  def downcase_fields
    self.city.downcase!
    self.state.downcase!
    self.street.downcase!
  end

  def formatted_full
    "#{street}, #{city}, #{state} #{zip}".titleize
  end
end
