require 'rails_helper'

RSpec.describe "SelfEsteemTrainings", type: :request do
  describe "GET /new" do
    it "returns http success" do
      get "/self_esteem_trainings/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /create" do
    it "returns http success" do
      get "/self_esteem_trainings/create"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get "/self_esteem_trainings/show"
      expect(response).to have_http_status(:success)
    end
  end

end
