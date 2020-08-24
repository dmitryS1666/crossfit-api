require 'rails_helper'

RSpec.describe 'Products API', type: :request do
  describe 'get all products', type: :request do
    let!(:products) { FactoryBot.create_list(:product_rand, 10) }

    before { get '/api/v1/products' }
    it 'returns all products' do
      expect(JSON.parse(response.body)['data'].size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(:success)
    end
  end
end
