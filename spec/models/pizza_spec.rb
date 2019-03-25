describe Pizza do
  subject { create(:pizza) }

  describe 'associations' do
    it { should belong_to(:specialty_type) }
    it { should have_many(:pizza_toppings) }
    it { should have_many(:toppings).through(:pizza_toppings) }
  end

  describe 'validations' do
    it { should validate_presence_of(:specialty_type_id) }
    it { should validate_presence_of(:specialty_type_price) }
    it { should validate_numericality_of(:specialty_type_price).is_greater_than_or_equal_to(0) }
    it { should validate_numericality_of(:specialty_type_price).is_less_than(1000000) }
  end
end
