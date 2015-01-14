FactoryGirl.define do
  factory :user do
    name "Sam Adams"
    sequence(:email, 100) { |n| "Person#{n}@example.com" }
    password "secret"
    password_confirmation "secret"
  end
end
