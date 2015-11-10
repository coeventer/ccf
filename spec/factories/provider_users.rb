# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :provider_user do
    uuid "MyString"
    provider "MyString"
    user_id 1
    token "MyString"
  end
end
