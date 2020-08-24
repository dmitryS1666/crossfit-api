require 'rails_helper'

RSpec.describe 'SubCategories API', type: :request do
  describe 'get all categories', type: :request do
    let!(:sub_categories) { FactoryBot.create_list(:sub_category_rand, 10) }

    before { get '/api/v1/sub-categories' }
    it 'returns all sub_categories' do
      expect(JSON.parse(response.body)['data'].size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(:success)
    end
  end
end
