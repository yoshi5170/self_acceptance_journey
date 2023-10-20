require 'rails_helper'

RSpec.describe "Questions", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/questions/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /result" do
    it "returns http success" do
      get "/questions/result"
      expect(response).to have_http_status(:success)
    end
  end

end
