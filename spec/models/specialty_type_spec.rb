describe SpecialtyType do
  subject { create(:specialty_type) }

  describe 'validations' do
    it { should validate_presence_of(:available) }
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:price) }
    it { should validate_numericality_of(:price).is_greater_than_or_equal_to(0) }
    it { should validate_numericality_of(:price).is_less_than(1000000) }
  end
end
