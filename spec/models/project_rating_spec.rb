require 'spec_helper'

describe ProjectRating do
  it "should belong to a project"
  it "should belong to a user"
  it "should require a rating"
  it "should require a description"
  it "should allow one comment per user/project combination"
  it "should be editable and deletable by mod"

  context "#slack_message" do
  let(:organization) { create :organization }
    subject { create(:project_rating, user: build(:user, name: "Bob"), project: create(:project, organization: organization, title: "Project") ) }
    it "generates a nice looking slack message" do
      allow(subject.project).to receive(:url) { "http://example.com" }
      expect(subject.slack_message).to match("Bob liked project Project: http://example.com")
    end
  end

end
