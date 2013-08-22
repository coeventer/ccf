# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :project_comment do
    project_id 1
    user_id 1
    title "MyString"
    description "MyText"
  end
end
