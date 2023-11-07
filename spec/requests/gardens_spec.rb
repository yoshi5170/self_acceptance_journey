require 'rails_helper'

RSpec.describe 'Gardens', type: :request do
  describe 'GET /show' do
    it 'returns http success' do
      get '/gardens/show'
      expect(response).to have_http_status(:success)
    end
  end
end
