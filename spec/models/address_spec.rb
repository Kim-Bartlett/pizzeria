describe Address do
  subject { create(:address) }

  describe 'validations' do
    it { should validate_presence_of(:city) }
    it { should validate_presence_of(:state) }
    it { should validate_presence_of(:street) }
    it { should validate_presence_of(:zip) }
  end

  describe 'formatted_full' do
    it 'formats the full address correctly' do
      expect(subject.formatted_full).to eq("#{subject.street}, #{subject.city}, #{subject.state} #{subject.zip}".titleize)
    end
  end
end
