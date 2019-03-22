describe Order do
  subject { create(:order) }

  describe 'associations' do
    it { should belong_to(:address).optional }
    it { should belong_to(:customer) }
    it { should have_many(:pizzas) }
  end

  describe 'validations' do
    it { should validate_presence_of(:customer_id) }
    it { should validate_presence_of(:status) }
    it { should validate_presence_of(:total_price) }
    it { should validate_numericality_of(:total_price).is_greater_than_or_equal_to(0) }
    it { should validate_numericality_of(:total_price).is_less_than(1000000) }

    describe 'is delivery' do
      subject { create(:order, delivery: true) }
      it { should validate_presence_of(:address_id) }
    end

    describe 'is pickup' do
      subject { create(:order, delivery: false) }
      it { should_not validate_presence_of(:address_id) }
    end
  end

  describe 'status' do
    let(:statuses) { [:placed, :preparing, :delivering, :ready_for_pickup, :complete, :cancelled] }

    it 'has the correct indexes' do
      statuses.each_with_index do |item, index|
        expect(described_class.statuses[item]).to eq index
      end
    end
  end
end
