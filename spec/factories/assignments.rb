FactoryGirl.define do
  factory :assignment do
    name "assignment_name"
    description "assignment_description"
    
    trait(:with_list) do
      association :to_do_list
    end 
  end
end
