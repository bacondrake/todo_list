FactoryGirl.define do
  factory :todo do |f|
    f.id 1
    f.content "This is a todo"
    f.section "Chores"
    f.completed false
  end

  factory :invalid_todo, parent: :todo do |f|
    f.id 1
    f.content ""
    f.section ""
    f.completed false
  end
end