# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :invitation do
    email "MyString"
    token "MyString"
    organization_id 1
    context_type "MyString"
    context_id 1
    status "MyString"
  end
end
