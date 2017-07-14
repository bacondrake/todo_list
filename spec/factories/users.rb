FactoryGirl.define do
  factory :user do
    # sequence(:email) { |i| "example_#{i}@email.com"}
    email "example_1@email.com"
    password "foobar"
  end
end
