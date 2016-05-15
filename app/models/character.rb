class Character < ActiveRecord::Base
  validates :name, :health, :strength, :user, presence: true
  validates :name, length: { in: 3..20 }
  validates :health, numericality: { only_integer: true, greater_than_or_equal_to: 10, less_than_or_equal_to: 90 }
  validates :strength, numericality: { only_integer: true, greater_than_or_equal_to: 2, less_than_or_equal_to: 20 }

  belongs_to :user
end
