# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user, :aliases => [:project_owner] do
    name "MyString"
    uid "MyString"
    deptid "MyString"
    department "MyString"
    admin false
    verified true
    alert_when_owner true
    alert_when_commenter true
    email "example@example.com"

    factory :owner_with_alert do
        alert_when_owner true
        email "owner_with_alert@example.com"
    end

    factory :owner_without_alert do
        alert_when_owner false
    end

    factory :commenter_with_alert do
        alert_when_commenter true
        email "commenter_with_alert@example.com"
    end

    factory :commenter_without_alert do
        alert_when_commenter false
    end
  end
end
