# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    name "MyString"
    uid "MyString"
    deptid "MyString"
    department "MyString"
    email "MyString"
    admin false
  end
end
