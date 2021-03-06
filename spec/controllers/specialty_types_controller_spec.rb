
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
  end
end
