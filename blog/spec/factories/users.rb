FactoryGirl.define do
  factory :user do
    first_name 'fname'
    last_name 'lname'
    email 'user@example.com'
    password 'password'
  end
end
