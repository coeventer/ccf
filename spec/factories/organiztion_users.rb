# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :organization_user do
    organization_id 1
    user_id 1
    verified false
    admin false
  end
end
