require 'rails_helper'

RSpec.shared_examples "#show free access" do
  
  let!(:character){ FactoryGirl.create(:character, name: "godzilla", health: 50, strength: 10) }
  let!(:another_user){ FactoryGirl.create(:user, username: "Ash Kitchum") }

  before(:each) do
    get "/characters/#{character.id}.json", {}, auth_header
  end

  it "gets expected character info" do
    expect(json.except('user')).to eq({'id' => character.id, 'name' => 'godzilla', 'health' => 50, 'strength' => 10})
  end

  it "gets related user info" do
    expect(json.slice('user')).to eq({'user' => { 'username' => character.user.username, 'id' => character.user_id } })
  end

end
