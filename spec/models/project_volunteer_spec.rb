require 'spec_helper'

describe ProjectVolunteer do
  it "should belong to a project"
  it "should belong to a user"
  it "should notify the project owner when created"
  it "should notify the project owner when destroyed"

  it "should be unique between a user and project"
  it "should not be allowed if project does not have an event"
  it "should not be allowed if project event expired"

  context "#slack_message" do
    before do
      ProjectVolunteer.skip_callback(:validate, :limit_projects)
    end
    let(:organization) { create :organization }
    subject { create(:project_volunteer, user: build(:user, name: "Bob"), project: create(:project, organization: organization, title: "Project") ) }
    it "generates a nice looking slack message" do
      allow(subject.project).to receive(:url) { "http://example.com" }
      expect(subject.slack_message).to match("Bob has volunteered for Project: http://example.com")
    end
  end
end
