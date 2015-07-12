require 'factory_girl'

FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "user#{n}@example.com" }
    password 'password'
    password_confirmation 'password'
    first_name 'John'
    last_name 'Smith'
    unit '1A'
    role 'tenant'
    building_id 1
    neighborhood_id 1
    phone '123-456-7890'
    description 'This is a description.'
  end

  factory :problem do
    sequence(:title) { |n| "Heat's broken#{n}!" }
    description "Heat's broken again!"
    category_id 1
    urgency_level_id 1
    status_id 1
    user_id 1
  end
end
