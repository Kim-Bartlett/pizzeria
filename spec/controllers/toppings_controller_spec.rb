
describe ToppingsController do
  render_views

  let!(:toppings) { create_list :topping, 3 }
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
      expect(body['toppings'].first.keys).to contain_exactly('name', 'price', 'id', 'available')
    end
  end
end
