FactoryGirl.define do
  factory :user do
    sequence(:name) { |n| "user_#{n}"}
    email { "#{name}@test.com" }
    password "12345678"

    transient do
      lists_count 1
    end

    trait :with_lists do
      after(:create) do |user, eval|
        create_list(:to_do_list, eval.lists_count, user: user )
      end
    end

    trait :with_public_lists do
      after(:create) do |user, eval|
        create_list(:to_do_list, eval.lists_count, :public, user: user)
      end
    end
  end
end
