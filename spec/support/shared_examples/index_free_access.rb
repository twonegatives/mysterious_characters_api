require 'rails_helper'

RSpec.shared_examples "#index free access" do |parameters|
  
  let!(:character_1){ FactoryGirl.create(:character) }
  let!(:character_2){ FactoryGirl.create(:character, user: FactoryGirl.create(:admin)) }
  
  let(:auth_header){ { 'HTTP_AUTHORIZATION' => ActionController::HttpAuthentication::Basic.encode_credentials(user.username, user.password) } }

  before(:each) do
    get '/characters.json', {}, auth_header
  end

  it "gets all characters" do
    expect(json['characters'].size).to eq parameters[:expected_chars_amount]
  end

  it "deliveres expected fields" do
    expect(json['characters'].first.keys).to match_array ['name', 'health', 'strength', 'user']
  end

end
