FactoryGirl.define do
  factory :todo do
    id 1
    content "This is a todo"
    section "Chores"
    completed false
  end
end