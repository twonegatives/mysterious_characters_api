FactoryGirl.define do
  factory :character do
    name{ (Faker::Superhero.name*3).first(18) }
    health{ Faker::Number.between(20, 80) }
    strength{ Faker::Number.between(4, 18) }
    user
  end
end
