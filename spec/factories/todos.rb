FactoryBot.define do
  factory :todo do
    content { "This is a todo" }
    section { "This is a section" }

    factory :todo_complete do
      completed { true }
    end
  end
end
