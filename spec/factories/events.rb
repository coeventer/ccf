# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :event do
    title "MyString"
    start_date "2013-08-21"
    end_date "2013-08-21"
    voting_end_date "2013-08-21"
  end
end
