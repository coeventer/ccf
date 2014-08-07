# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :event do
    title "MyString"
    start_date "2013-08-21"
    end_date "2013-08-21"
    voting_end_date "2013-08-21"
    volunteer_end_date "2013-08-21"
    voting_enabled true
    volunteering_enabled true
    description "This is an event"
    schedule "Everyday 8am - 9pm"
    registration_end_dt "2013-08-20"
    registration_maximum 126
    live true
  end
end
