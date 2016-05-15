class User < ActiveRecord::Base
  has_secure_password
 
  # NOTE: validations, callbacks and even relations would
  # better be moved to service layer at some point in the future
  
  validates :username, :role, :password, presence: true
  validates :username, uniqueness: true
  validates :password, length: { in: 6..20 }
  validates :username, length: { in: 3..20 }
  validates :role, inclusion: %w[user admin]

  has_many :characters, dependent: :destroy
end
