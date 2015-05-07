FactoryGirl.define do
  factory :user do |f|
    f.id 1
    f.email "email@example.com"
    f.password "Password1"
  end

  factory :invalid_user do |f|
    f.id 1
    f.email "email.com/example"
    f.password "cat"
  end
end