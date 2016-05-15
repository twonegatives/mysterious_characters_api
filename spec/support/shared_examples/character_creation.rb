require 'rails_helper'
RSpec.shared_examples "character creation" do

  let(:auth_header){ { 'HTTP_AUTHORIZATION' => ActionController::HttpAuthentication::Basic.encode_credentials(user.username, user.password) } }

  before(:each) do
    post "/characters.json", {character: {name: 'godzilla', health: 50, strength: 10}}, auth_header
  end

  it "obtains character id" do
    expect(json['id']).to be_kind_of Numeric
  end

  it "saves passed character info" do
    expect(Character.find_by(id: json['id']).attributes.slice('name', 'health', 'strength')).to eq({'name' => 'godzilla', 'health' => 50, 'strength' => 10})
  end

  it "sets according user id" do
    expect(Character.find_by(id: json['id']).user_id).to eq(user.id)
  end

end
