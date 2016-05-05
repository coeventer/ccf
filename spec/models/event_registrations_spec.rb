require 'spec_helper'

describe EventRegistration do
  let(:organization) { create :organization }
  let(:event) { create :event, organization: organization }
  let(:user)  { create :user, email: "test@test.com" }

  it "should require a name" do
    should validate_presence_of(:name)
  end

  it "should belong to an event" do
    should belong_to(:event)
  end

  it "should belong to a user" do
    should belong_to(:user)
  end

  it "should call the mail delivery method" do
    event_registration = build :event_registration, user: user, event: event
    expect(event_registration).to receive(:send_notification)
    event_registration.save
  end
end
