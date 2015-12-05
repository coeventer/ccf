require_relative '../spec_helper'

describe ProjectComment do
  it "attempts to deliver emails when a project is commented upon" do
    project_comment = build :project_comment 
    expect(project_comment).to receive(:send_notification)
    project_comment.save
  end
end
