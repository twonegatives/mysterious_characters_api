FactoryGirl.define do
  factory :character do
    name{ Faker::Superhero.name(min_length: 3, max_length: 18) }
    health{ Faker::Number.between(20, 80) }
    strength{ Faker::Number.between(4, 18) }
    user
  end
end
