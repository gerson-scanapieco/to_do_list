FactoryGirl.define do
  factory :to_do_list do
    sequence(:name) { |n| "list_#{n}" }
    list_type ToDoListTypes::PRIVATE

    trait :with_user do
      association :user
    end

    trait :public do
      list_type ToDoListTypes::PUBLIC
    end
  end
end
