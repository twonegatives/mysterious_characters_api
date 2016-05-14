require 'rails_helper'

describe "unmatched route", type: :request do
  it "returns json 404" do
    get '/unknown/path.json', {}, {}
    expect(response.headers["Content-Type"]).to include "application/json"
    expect(response.code).to eq "404"
  end
end
