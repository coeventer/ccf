require 'spec_helper'

describe Organization do
  subject { create :organization }
  let(:user) { create :user }

  it "should properly identify org admins" do
    create(:organization_user, user: user, organization: subject, admin: true)
    expect(subject.admin?(user)).to be true
  end

  it "should properly identify org non-admins" do
    create(:organization_user, user: user, organization: subject, admin: false)
    expect(subject.admin?(user)).to be false
  end

  it "should properly identify org verified members" do
    create(:organization_user, user: user, organization: subject, verified: true)
    expect(subject.verified?(user)).to be true
  end

  it "should properly identify org unverified members" do
    create(:organization_user, user: user, organization: subject, verified: false)
    expect(subject.verified?(user)).to be false
  end

  it "should properly identify org members" do
    create(:organization_user, user: user, organization: subject, verified: true)
    expect(subject.member?(user)).to be true
  end
end
