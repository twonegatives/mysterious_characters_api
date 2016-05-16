require 'rails_helper'

describe User, :type => :model do
  # NOTE: could also be done with https://github.com/thoughtbot/shoulda-matchers
  let(:user){ FactoryGirl.build(:user) }
  
  context "validations & creation" do
    it "can be saved successfully" do
      expect{ user.save! }.to change{ User.count }.by(1)
    end

    it "does not allow to save duplicated username" do
      user.save!
      duplicate = user.dup
      duplicate.valid?
      expect(duplicate.errors).to have_key(:username)
    end

    it "does not allow to save short username" do
      user.username = 'a'
      user.valid?
      expect(user.errors).to have_key(:username)
    end

    it "does not allow to save short passwords" do
      user.password = 'short'
      user.valid?
      expect(user.errors).to have_key(:password)
    end

    it "does not allow to save unallowed roles" do
      user.role = 'moderator'
      user.valid?
      expect(user.errors).to have_key(:role)
    end
  end

  context "relations" do
    it "destroyes dependent characters" do
      user.save!
      FactoryGirl.create(:character, user: user)
      expect{ user.destroy }.to change{ Character.count }.by(-1)
    end
    
    it "destroyes dependent comments" do
      user.save!
      FactoryGirl.create(:comment, user: user)
      expect{ user.destroy }.to change{ Comment.count }.by(-1)
    end
  end
end
