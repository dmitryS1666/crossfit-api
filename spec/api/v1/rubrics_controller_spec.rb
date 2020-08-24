require 'rails_helper'

RSpec.describe 'Rubrics API', type: :request do
  describe 'get all rubrics', type: :request do
    let!(:rubrics) { FactoryBot.create_list(:rubric_rand, 10) }

    before { get '/api/v1/rubrics' }
    it 'returns all rubrics' do
      expect(JSON.parse(response.body)['data'].size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(:success)
    end
  end
end
