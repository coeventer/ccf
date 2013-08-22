# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :project_rating do
    project_id 1
    user_id 1
    rating 1
  end
end
