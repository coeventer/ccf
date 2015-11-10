require 'spec_helper'

describe EventRegistration do
  let(:organization) { create :organization }
  let(:event) { create :event, organization }
  let(:user)  { create :user, email: "test@test.com" }

  it "should require a participation level" do
    should validate_presence_of(:participation_level)
  end

  it "should belong to an event" do
    should belong_to(:event)
  end

  it "should belong to a user" do
    should belong_to(:user)
  end

  it "should deliver an email after being created" do
    ActionMailer::Base.clear_cache
    create :event_registration, user: user, event: event
    ActionMailer::Base.cached_deliveries.count.should eq(1)
    ActionMailer::Base.cached_deliveries.first.to.should eq(['test@test.com'])
  end
end
