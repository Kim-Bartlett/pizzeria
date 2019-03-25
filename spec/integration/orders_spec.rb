require 'swagger_helper'

describe 'Orders API' do
  let!(:toppings) { create_list :topping, 3 }
  let!(:specialty_types) { create_list :specialty_type, 3 }

  path '/orders' do
    post 'Place an order' do
      tags 'Orders'
      consumes 'application/json'
      examples
      parameter name: :order, in: :body, schema: {
        type: :object,
        properties: {
          order: {
            type: :object,
            properties: {
              delivery: { type: :boolean },
              address: {
                  type: :object,
                  properties: {
                    city: { type: :string },
                    state: { type: :string },
                    street: { type: :string },
                    zip: { type: :string },
                   }
                },
                customer: {
                    type: :object,
                    properties: {
                      email: { example: 'test@gmail.com', type: :string, pattern: URI::MailTo::EMAIL_REGEXP },
                      first_name: { type: :string },
                      last_name: { type: :string },
                      phone: { example: '555-555-5555', type: :string, pattern: /\(?[0-9]{3}\)?-[0-9]{3}-[0-9]{4}/ },
                     },
                     required: ['email', 'first_name', 'last_name', 'phone']
                  },
                  pizzas: {
                      type: :array,
                      items: {
                          type: :object,
                          properties: {
                            quantity: { example: 1, type: :integer },
                            specialty_type_id: { example: 1, type: :integer },
                            topping_ids: { example: [1, 2, 3], type: :array, items: { type: :integer } }
                          },
                          required: ['quantity', 'specialty_type_id']
                        }
                  }
            },
            required: ['address', 'customer', 'pizzas']
          }
        },
        required: ['order']
      }
      produces 'application/json'

      response '201', 'Order created' do
        let(:order) do
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

        run_test!
      end
    end

    get 'Retrieves a list of orders' do
      tags 'Orders'
      produces 'application/json'
      parameter name: :filter, in: :query, required: false, enum: ['all', 'closed', 'open'], type: :string

      response '200', 'success' do
        let!(:orders) { create_list :order, 3 }
        run_test!
      end
    end
  end

  path '/orders/:id' do
    get 'Retrieves a an order by id' do
      tags 'Orders'
      produces 'application/json'
      parameter name: :id, in: :path, required: true, type: :string

      response '200', 'success' do
        let(:id) { create(:order).id }
        run_test!
      end
    end

    put 'Updates the status of an order' do
      tags 'Orders'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :order, in: :body, schema: {
          type: :object,
          properties: {
            order: {
              type: :object,
              properties: {
                  id: { type: :integer },
                  status: { type: :string, enum: ['placed', 'preparing', 'delivering', 'ready_for_pickup', 'complete', 'cancelled'] }
                  }
                }, required: ['id', 'status']
            }, required: ['order']
          }

      response '200', 'success' do
        let(:id) { create(:order).id }
        let!(:order) do
         {   order: {
                id: id,
                status: 'complete'
            }
        }
        end
        run_test!
      end
    end
  end
end
