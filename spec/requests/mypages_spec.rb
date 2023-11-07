require 'rails_helper'

RSpec.describe 'Mypages', type: :request do
  describe 'GET /show' do
    it 'returns http success' do
      get '/mypages/show'
      expect(response).to have_http_status(:success)
    end
  end
end
