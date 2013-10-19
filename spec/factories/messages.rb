# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :message do
    title "Introduction message"
    body "Hello World!"
    rescended false
  end
end
