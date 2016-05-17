require 'rails_helper'

describe "Comments", type: :request do
  describe "GET 'index'" do
    context "admin" do
      let(:user){ FactoryGirl.create(:admin) }
      it_behaves_like "comments #index free access"
    end
    context "user" do
      let(:user){ FactoryGirl.create(:user) }
      it_behaves_like "comments #index free access"
    end
    context "guest" do
      let(:user){ FactoryGirl.create(:guest) }
      it_behaves_like "comments #index free access"
    end
  end
  
  describe "POST 'create'" do
    let!(:character){ FactoryGirl.create(:character) }
    context "admin" do
      let(:user){ FactoryGirl.create(:admin) }
      it_behaves_like "comments creation"
    end
    context "user" do
      let(:user){ FactoryGirl.create(:user) }
      it_behaves_like "comments creation"
    end
    context "guest" do
      let(:user){ FactoryGirl.create(:guest) }
      it "can not create new comment" do
        post "/characters/#{character.id}/comments.json", {comment: {body: "wow that character rocks!"}}, auth_header
        expect(response.headers["Content-Type"]).to include "application/json"
        expect(response).to have_http_status(403)
      end
    end
  end
  
  describe "DELETE 'destroy'" do
    context "admin" do
      let(:user){ FactoryGirl.create(:admin) }
      context "foreign comment" do
        let!(:comment){ FactoryGirl.create(:comment) }
        it "can remove" do
          expect{ delete "/characters/#{comment.character_id}/comments/#{comment.id}.json", {}, auth_header }.to change{ Comment.count }.by(-1)
        end
      end
    end
    context "user" do
      let(:user){ FactoryGirl.create(:user) }
      context "own comment" do
        let!(:comment){ FactoryGirl.create(:comment, user: user) }
        it "can remove" do
          expect{ delete "/characters/#{comment.character_id}/comments/#{comment.id}.json", {}, auth_header }.to change{ Comment.count }.by(-1)
        end
      end
      context "foreign comment" do
        let!(:comment){ FactoryGirl.create(:comment) }
        it "can not remove" do
          delete "/characters/#{comment.character_id}/comments/#{comment.id}.json", {}, auth_header
          expect(response.headers["Content-Type"]).to include "application/json"
          expect(response).to have_http_status(403)
        end
      end
    end
    context "guest" do
      let(:user){ FactoryGirl.create(:guest) }
      context "foreign comment" do
        let!(:comment){ FactoryGirl.create(:comment) }
        it "can not remove" do
          delete "/characters/#{comment.character_id}/comments/#{comment.id}.json", {}, auth_header
          expect(response.headers["Content-Type"]).to include "application/json"
          expect(response).to have_http_status(403)
        end
      end
    end
  end
end
