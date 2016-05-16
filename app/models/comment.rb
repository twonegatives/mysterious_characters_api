class Comment < ActiveRecord::Base
  validates :user, :character, :body, presence: true
  validates :body, length: { in: 1..250 }

  belongs_to :user, inverse_of: :comments
  belongs_to :character, inverse_of: :comments
end
