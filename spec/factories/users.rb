FactoryGirl.define do
  factory :user do
    sequence :email do |n|
      "user#{n}@gmail.com"
    end
    password "12345678"
    confirmed_at Time.now
  end
end
