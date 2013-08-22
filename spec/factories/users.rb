# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    name "MyString"
    x500id "MyString"
    deptid "MyString"
    department "MyString"
    email "MyString"
    admin false
  end
end
