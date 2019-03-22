require 'swagger_helper'

describe 'Types API' do
  path '/specialty_types' do
    get 'Retrieves a list of pizza types' do
      tags 'Types'
      produces 'application/json'

      response '200', 'success' do
        let!(:specialty_types) { create_list :specialty_type, 3 }
        run_test!
      end
    end
  end
end
