# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :project_volunteer do
    project_id 1
    user_id 1
    interest_level "MyString"
  end
end
