require 'spec_helper'

describe Organization do
  subject { create :organization }
  let(:user) { create :user }

  it "should properly identify org admins" do
    create(:organization_user, user: user, organization: subject, admin: true)
    subject.admin?(user).should == true
  end

  it "should properly identify org non-admins" do
    create(:organization_user, user: user, organization: subject, admin: false)
    subject.admin?(user).should == false
  end

  it "should properly identify org verified members" do
    create(:organization_user, user: user, organization: subject, verified: true)
    subject.verified?(user).should == true
  end

  it "should properly identify org unverified members" do
    create(:organization_user, user: user, organization: subject, verified: false)
    subject.verified?(user).should == false
  end

  it "should properly identify org members" do
    create(:organization_user, user: user, organization: subject, verified: true)
    subject.member?(user).should == true
  end
end
