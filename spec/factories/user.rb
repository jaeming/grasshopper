FactoryGirl.define do
  factory :user do
    name "Sam Adams"
    sequence(:email, 100) { |n| "Person#{n}@example.com" }
    password "helloworld"
    password_confirmation "helloworld"
  end
end
