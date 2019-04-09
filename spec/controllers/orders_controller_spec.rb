describe OrdersController do
  let!(:toppings) { create_list :topping, 3 }
  let!(:specialty_types) { create_list :specialty_type, 3 }
  let!(:order) { create(:order) }

  let(:body) { JSON.parse(response.body) }

  fdescribe 'GET #index' do
    it 'returns http success' do
      get :index, format: :json
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST #create' do
    let(:create_params) do
      {
        order: {
          delivery: true,
          address: {
            city: 'Pittsburgh',
            state: 'PA',
            street: '3000 Forbes Ave',
            zip: '15203'
          },
          customer: {
            email: 'test@gmail.com',
            first_name: 'jane',
            last_name: 'doe',
            phone: '555-555-5555',
          },
          pizzas: [
            {
              quantity: 1,
              specialty_type_id: specialty_types[0].id,
              topping_ids: [ toppings[0].id ]
            },
            {
              quantity: 2,
              specialty_type_id: specialty_types[1].id,
              topping_ids: [ toppings[1].id, toppings[2].id ]
            }
          ]
        }
      }
    end

    it 'returns http success' do
      post :create, format: :json, params: create_params
      expect(response).to have_http_status(:success)
      puts Pizza.all.inspect
    end
  end

  describe 'GET #show' do
    it 'returns http success' do
      get :show, params: { id: order.id, order: { id: order.id } }, format: :json
      expect(response).to have_http_status(:success)
    end
  end

  describe 'PUT #update' do
    let!(:order) { create(:order, id: 1) }
    it 'returns http success' do
      put :update, params: { id: order.id, order: { id: order.id, status: 'cancelled' } }, format: :json
      expect(response).to have_http_status(:success)
    end
  end
end
