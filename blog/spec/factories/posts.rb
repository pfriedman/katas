FactoryGirl.define do
  factory :post do
    title "MyString"
    body "MyText"
    association :user, factory: :user
  end
end
