require_relative '../spec_helper'

describe ProjectComment do
  it "attempts to deliver emails when a project is commented upon" do
    project_comment = build :project_comment
    expect(project_comment).to receive(:send_notification)
    project_comment.save
  end

  context "#url" do
      let(:organization) { create :organization }
      subject { create(:project_comment, project: create(:project, project_owner: create(:user), organization: organization, title: "Project"))  }
    it "generates the proper url" do
      expect(subject.url).to eq("http://lvh.me/projects/1/project_comments/1")
    end
  end

  context "#slack_message" do
    let(:organization) { create :organization }
    describe "with an event" do
      subject { create(:project_comment, project: create(:project, project_owner: create(:user), organization: organization, title: "Project"))  }
      it "generates a nice looking slack message" do
        user = double
        allow(subject).to receive(:url) { "http://example.com" }
        allow(subject).to receive(:user) { user }
        allow(user).to receive(:name) { "Bob" }
        expect(subject.slack_message).to match("Bob has commented on Project: http://example.com")
      end
    end
  end
end
