require 'swagger_helper'

describe 'Toppings API' do
  path '/toppings' do
    get 'Retrieves a list of toppings' do
      tags 'Toppings'
      produces 'application/json'

      response '200', 'success' do
        let!(:toppings) { create_list :topping, 3 }
        run_test!
      end
    end
  end
end
