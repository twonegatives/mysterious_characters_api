class User < ActiveRecord::Base
  has_secure_password
  
  validates :username, :role, :password, presence: true
  validates :username, uniqueness: true
  validates :password, length: { in: 6..20 }
  validates :username, length: { in: 3..20 }
  validates :role, inclusion: %w[user admin]
end
