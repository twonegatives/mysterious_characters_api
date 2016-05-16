require 'rails_helper'
RSpec.shared_examples "comments creation" do

  context "successfull creation" do
    before(:each) do
      post "/characters/#{character.id}/comments.json", {comment: {body: "wow that character rocks!"}}, auth_header
    end

    it "saves passed comment" do
      expect(character.reload.comments.pluck(:body)).to include("wow that character rocks!")
    end

    it "sets according user_id and character_id" do
      comment = character.reload.comments.last
      expect(comment.attributes.slice('user_id', 'character_id')).to eq({"user_id" => user.id, "character_id" => character.id})
    end
  end

  context "validation fail" do
    it "does not save comment" do
      expect{ post "/characters/#{character.id}/comments.json", {comment: {body: Faker::Lorem.paragraph(100)}}, auth_header }.
        not_to change{ Comment.count }
    end

    it "returns errors list" do
      post "/characters/#{character.id}/comments.json", {comment: {body: Faker::Lorem.paragraph(100)}}, auth_header
      expect(response.headers["Content-Type"]).to include "application/json"
      expect(response).to have_http_status(400)
      expect(json['errors']).to include('Body is too long (maximum is 250 characters)')
    end
  end

end
