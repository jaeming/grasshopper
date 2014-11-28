FactoryGirl.define do
  factory :board do
    title "Board Title"
    text "Board text must be a certain length"
    association :user
  end
end
