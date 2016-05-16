FactoryGirl.define do
  factory :user, class: User do
    username{ (Faker::Internet.user_name*3).first(18) }
    password{ Faker::Internet.password(10, 15) }
    role 'user'

    factory :admin do
      role 'admin'
    end

    factory :guest do
      role 'guest'
    end
  end
end
