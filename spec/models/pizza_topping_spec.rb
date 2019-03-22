describe PizzaTopping do
  subject { create(:pizza_topping) }

  describe 'associations' do
    it { should belong_to(:pizza) }
    it { should belong_to(:topping) }
  end

  describe 'validations' do
    it { should validate_presence_of(:pizza_id) }
    it { should validate_presence_of(:topping_id) }
    it { should validate_presence_of(:price) }
    it { should validate_numericality_of(:price).is_greater_than_or_equal_to(0) }
    it { should validate_numericality_of(:price).is_less_than(1000000) }
  end
end
