describe OrdersController do
  let!(:toppings) { create_list :topping, 3 }
  let!(:specialty_types) { create_list :specialty_type, 3 }

  let(:body) { JSON.parse(response.body) }

  describe 'GET #index' do
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
      puts '!!!!'
      post :create, format: :json, params: create_params
      puts body.inspect
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET #show' do
    it 'returns http success' do
      get :show, params: { id: 1 }, format: :json
      expect(response).to have_http_status(:success)
    end
  end

  describe 'PUT #update_status' do
    it 'returns http success' do
      put :update_status, params: { id: 1 }, format: :json
      expect(response).to have_http_status(:success)
    end
  end
end
