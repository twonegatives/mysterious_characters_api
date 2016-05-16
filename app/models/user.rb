class User < ActiveRecord::Base
  has_secure_password
 
  validates :username, :role, :password, presence: true
  validates :username, uniqueness: true
  validates :password, length: { in: 6..20 }
  validates :username, length: { in: 3..20 }
  validates :role, inclusion: %w[user admin]

  has_many :characters, dependent: :destroy, inverse_of: :user
  has_many :comments, dependent: :destroy, inverse_of: :user
end
