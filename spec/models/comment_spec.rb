require 'rails_helper'

RSpec.describe Comment, type: :model do
  let!(:comment){ FactoryGirl.build(:comment) }
  
  context "validations & creation" do
    it "can be saved successfully" do
      expect{ comment.save! }.to change{ Comment.count }.by(1)
    end

    it "cant be saved without user" do
      comment.user_id = nil
      comment.valid?
      expect(comment.errors).to have_key(:user)
    end

    it "cant be saved without character" do
      comment.character_id = nil
      comment.valid?
      expect(comment.errors).to have_key(:character)
    end

    it "cant be saved with too long body" do
      comment.body = Faker::Lorem.paragraph(100)
      comment.valid?
      expect(comment.errors).to have_key(:body)
    end
  end
end
