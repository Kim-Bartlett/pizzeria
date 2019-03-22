describe Customer do
  subject { create(:customer) }

  describe 'associations' do
    it { should have_many(:customer_addresses) }
    it { should have_many(:addresses).through(:customer_addresses) }
  end

  describe 'presence validations' do
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
    it { should validate_presence_of(:phone) }
  end

  describe 'email format validation' do
    it { should allow_value('email@gmail.com').for(:email) }
    it { should_not allow_value('email').for(:email) }
    it { should_not allow_value('emailgmail.com').for(:email) }
  end

  describe 'phone format validation' do
    it { should allow_value('555-555-5555').for(:phone) }
    it { should allow_value('(555)-555-5555').for(:phone) }
    it { should_not allow_value('5555').for(:phone) }
  end
end
