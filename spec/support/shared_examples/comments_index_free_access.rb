require 'rails_helper'

RSpec.shared_examples "comments #index free access" do
  
  let!(:character){ FactoryGirl.create(:character) }
  let!(:comment_1){ FactoryGirl.create(:comment, character: character, body: "the first comment") }
  let!(:comment_2){ FactoryGirl.create(:comment, character: character, body: "the second comment") }
  
  it "gets all comments" do
    get "/characters/#{character.id}/comments.json", {}, auth_header
    expect(json['comments'].size).to eq 2 
  end

  it "deliveres expected fields" do
    expected_result = {
      "id" => comment_1.id,
      "body" => comment_1.body,
      "user" => {
        "id" => comment_1.user.id,
        "username" => comment_1.user.username
      }
    }
    get "/characters/#{character.id}/comments.json", {}, auth_header
    expect(json['comments'].first).to eq expected_result 
  end

  it "takes limit and offset in count" do
    get "/characters/#{character.id}/comments.json", {limit: 1, offset: 1}, auth_header
    expect(json['comments'].size).to eq 1
    expect(json['comments'][0]['body']).to eq "the second comment" 
  end

end
