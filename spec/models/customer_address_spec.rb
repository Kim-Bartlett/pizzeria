describe CustomerAddress do
  subject { create(:customer_address) }

  describe 'associations' do
    it { should belong_to(:address) }
    it { should belong_to(:customer) }
  end

  describe 'validations' do
    it { should validate_presence_of(:address_id) }
    it { should validate_presence_of(:customer_id) }
  end
end
