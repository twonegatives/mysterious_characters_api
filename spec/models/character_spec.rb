require 'rails_helper'

describe Character, type: :model do
  # NOTE: could also be done with https://github.com/thoughtbot/shoulda-matchers
  let!(:character){ FactoryGirl.build(:character) }
  
  context "validations & creation" do
    it "can be saved successfully" do
      expect{ character.save! }.to change{ Character.count }.by(1)
    end

    it "does not allow to save character with negative health" do
      character.health = -1
      character.valid?
      expect(character.errors).to have_key(:health)
    end

    it "does not allow to save character with too short name" do
      character.name = nil
      character.valid?
      expect(character.errors).to have_key(:name)
    end

    it "does not allow to save character without strength value" do
      character.strength = nil
      character.valid?
      expect(character.errors).to have_key(:strength)
    end

    it "does not allow to save character without user" do
      character.user_id = nil
      character.valid?
      expect(character.errors).to have_key(:user)
    end
  end
  
  context "relations" do
    it "destroyes dependent comments" do
      character.save!
      FactoryGirl.create(:comment, character: character)
      expect{ character.destroy }.to change{ Comment.count }.by(-1)
    end
  end
end
