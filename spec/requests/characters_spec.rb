require 'rails_helper'

describe "Characters", type: :request do
  describe "GET 'index'" do
    context "admin" do
      let(:user){ FactoryGirl.create(:admin) }
      let!(:character){ FactoryGirl.create(:character, user: user) }
      it_behaves_like "characters #index free access", expected_chars_amount: 3
    end

    context "user" do
      let(:user){ FactoryGirl.create(:user) }
      let!(:character){ FactoryGirl.create(:character, user: user) }
      it_behaves_like "characters #index free access", expected_chars_amount: 3
    end

    context "guest" do
      let(:user){ FactoryGirl.create(:guest) }
      it_behaves_like "characters #index free access", expected_chars_amount: 2
    end
  end

  describe "GET 'show'" do
    context "admin" do
      let(:user){ FactoryGirl.create(:admin) }
      it_behaves_like "characters #show free access"
    end

    context "user" do
      let(:user){ FactoryGirl.create(:user) }
      it_behaves_like "characters #show free access"
    end

    context "guest" do
      let(:user){ FactoryGirl.create(:guest) }
      it_behaves_like "characters #show free access"

      it "gets 404 for wrong character_id" do
        get "/characters/100500.json", {}, auth_header
        expect(response.headers["Content-Type"]).to include "application/json"
        expect(response).to have_http_status(404)
      end
    end
  end

  describe "POST 'create'" do
    context "admin" do
      let(:user){ FactoryGirl.create(:admin) }
      it_behaves_like "character creation"
    end

    context "user" do
      let(:user){ FactoryGirl.create(:user) }
      it_behaves_like "character creation"
    end

    context "guest" do
      let(:user){ FactoryGirl.create(:guest) }
      it "can not create characters" do
        post "/characters.json", {character: {name: 'godzilla', health: 50, strength: 10}}, auth_header
        expect(response.headers["Content-Type"]).to include "application/json"
        expect(response).to have_http_status(403)
      end
    end
  end

  describe "PUT 'update'" do
    context "admin" do
      let(:user){ FactoryGirl.create(:admin) }
      context "foreign character" do
        let(:foreign_char){ FactoryGirl.create(:character) }
        
        it "updates attributes properly" do
          put "/characters/#{foreign_char.id}.json", {character: {name: "master splinter"}}, auth_header
          expect(foreign_char.reload.name).to eq "master splinter"
        end
      end
    end

    context "user" do
      let(:user){ FactoryGirl.create(:user) }
      
      context "owned character" do
        let(:owned_char){ FactoryGirl.create(:character, user: user) }
        it "updates attributes properly" do
          put "/characters/#{owned_char.id}.json", {character: {strength: 10, name: "donatello"}}, auth_header
          expect(owned_char.reload.name).to eq "donatello"
          expect(owned_char.strength).to eq 10
        end

        it "returns json 200" do
          put "/characters/#{owned_char.id}.json", {character: {strength: 10, name: "donatello"}}, auth_header
          expect(response.headers["Content-Type"]).to include "application/json"
          expect(response).to have_http_status(200)
        end

        it "returns json 400 if param missing" do
          put "/characters/#{owned_char.id}.json", {another_key: {strength: 10, name: "donatello"}}, auth_header
          expect(response.headers["Content-Type"]).to include "application/json"
          expect(response).to have_http_status(400)
        end
      end

      context "foreign character" do
        let(:foreign_char){ FactoryGirl.create(:character) }
        it "gets json 403" do
          put "/characters/#{foreign_char.id}.json", {character: {name: "master splinter"}}, auth_header
          expect(response.headers["Content-Type"]).to include "application/json"
          expect(response).to have_http_status(403)
        end
      end

    end

    context "guest" do
      let(:user){ FactoryGirl.create(:guest) }
      context "foreign character" do
        let(:foreign_char){ FactoryGirl.create(:character) }
        it "gets json 403" do
          put "/characters/#{foreign_char.id}.json", {character: {name: "master splinter"}}, auth_header
          expect(response.headers["Content-Type"]).to include "application/json"
          expect(response).to have_http_status(403)
        end
      end
    end
  end

  describe "DELETE 'destroy'" do
    context "admin" do
      let(:user){ FactoryGirl.create(:admin) }
      context "foreign character" do
        let!(:foreign_char){ FactoryGirl.create(:character) }
        it "removes it successfully" do
          expect{ delete "/characters/#{foreign_char.id}.json", {}, auth_header }.to change{ Character.count }.by(-1)
        end
      end
    end

    context "user" do
      let(:user){ FactoryGirl.create(:user) }
      context "owned character" do
        let!(:owned_char){ FactoryGirl.create(:character, user: user) }
        it "removes it successfully" do
          expect{ delete "/characters/#{owned_char.id}.json", {}, auth_header }.to change{ Character.count }.by(-1)
        end

        it "returns json 204" do
          delete "/characters/#{owned_char.id}.json", {}, auth_header
          expect(response).to have_http_status(204)
        end
      end

      context "foreign character" do
        let(:foreign_char){ FactoryGirl.create(:character) }
        it "gets json 403" do
          delete "/characters/#{foreign_char.id}.json", {}, auth_header
          expect(response.headers["Content-Type"]).to include "application/json"
          expect(response).to have_http_status(403)
        end
      end
    end

    context "guest" do
      let(:user){ FactoryGirl.create(:guest) }
      context "foreign character" do
        let!(:foreign_char){ FactoryGirl.create(:character) }
        it "gets json 403" do
          delete "/characters/#{foreign_char.id}.json", {}, auth_header
          expect(response.headers["Content-Type"]).to include "application/json"
          expect(response).to have_http_status(403)
        end
      end
    end
  end
end
