FactoryGirl.define do
  factory :comment do
    body{ Faker::Lorem.sentence }
    user
    character
  end
end
