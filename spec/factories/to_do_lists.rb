FactoryGirl.define do
  factory :to_do_list do
    sequence(:name) { |n| "sequence_#{n}" }
    list_type 1

    trait :with_user do
      association :user
    end
  end
end
