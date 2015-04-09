FactoryGirl.define do
  factory :assignment do
    name "assignment"
    description "description"
    
    trait(:with_list) do
      association :to_do_list
    end 
  end
end
