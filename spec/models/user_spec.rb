require 'rails_helper'

describe User, :type => :model do
  context "validations & creation" do
    let(:user){ User.new(username: "bob_smith", password: "password123", role: "user") }

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
end
