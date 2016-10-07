# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :tweet do
    user_id 1
    address "MyText"
    is_business_hour 1
    is_crowd 1
  end
end
