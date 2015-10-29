# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user, :aliases => [:project_owner] do
    name "MyString"
    uid "MyString"
    deptid "MyString"
    department "MyString"
    admin false
    verified true
    email "example@example.com"
  end
end
