# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :organization do
    name "MyString"
    subdomain "MyString"
    auto_verify_domains "MyString"
    auto_verify false
    description "MyString"
    website "MyString"
  end
end
