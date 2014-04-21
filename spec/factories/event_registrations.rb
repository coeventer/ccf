# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :event_registration, :class => 'EventRegistration' do
    event_id 1
    user_id 1
    note "This is my note regarding the registration"
    participation_level "Just visitings"
  end
end
