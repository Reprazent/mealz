FactoryGirl.define do
  factory :user do
    sequence(:username) { |n| "user-#{n}" }
  end

  factory :archived_user, parent: :user do
    archived_at { Time.now }
  end
end
