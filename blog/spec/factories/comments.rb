FactoryGirl.define do
  factory :comment do
    body "MyText"
    commentable_id 1
    commentable_type "MyString"
    association :user, factory: :user
  end
end
