
describe SpecialtyTypesController do
  render_views

  let!(:specialty_types) { create_list :specialty_type, 3 }
  let(:body) { JSON.parse(response.body) }

  describe 'GET #index' do
    before :each do
      get :index, format: :json
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'has the application/json content-type' do
      expect(response.content_type).to eq('application/json')
    end

    it 'returns the correct attributes' do
      expect(body['specialtyTypes'].first.keys).to contain_exactly('name', 'price', 'id', 'available')
    end
  end
end