# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :message do
    title "Introduction message"
    body "Hello World!"
    rescinded false
  end

  factory :message_log do
    message_id 1
    from "314-867-5309"
    called_at 1.day.ago 
  end
end
