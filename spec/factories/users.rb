FactoryGirl.define do
  factory :user do
    sequence :email do |n|
      "user#{n}@gmail.com"
    end
    password "12345678"
    confirmed_at Time.now

    factory :admin do
      after(:create) do |user|
        user.add_role :admin
      end
    end
  end
end
