require 'rails_helper'

describe "http errors", type: :request do
  context "unauthorized" do
    let!(:user){ FactoryGirl.build(:admin) }
    it "returns json 401" do
      get '/characters.json', {}, auth_header
      expect(response.headers["Content-Type"]).to include "application/json"
      expect(response).to have_http_status(401)
    end
  end

  context "not found" do
    let!(:user){ FactoryGirl.create(:admin) }
    it "returns json 404" do
      get '/unknown/path.json', {}, auth_header
      expect(response.headers["Content-Type"]).to include "application/json"
      expect(response).to have_http_status(404)
    end
  end
end
