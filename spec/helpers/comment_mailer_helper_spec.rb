require_relative '../spec_helper'

describe CommentMailerHelper do

  it "sends an emails when email alerts are enabled for everyone" do
    project_owner = create :project_owner, :with_notifications
    comment_user  = create :user, :with_notifications
    comment_users = CommentMailerHelper.get_project_users(project(project_owner, comment_user))
    expect(comment_users.first.id).to eq project_owner.id
    expect(comment_users.last.id).to eq comment_user.id
  end
  it "does not send emails when email alerts are disabled for everyone" do
    project_owner = create :project_owner, :without_notifications
    comment_user  = create :user, :without_notifications
    comment_users = CommentMailerHelper.get_project_users(project(project_owner, comment_user))
    expect(comment_users.first).to be nil
  end
  it "sends an emails when email alerts are enabled only for project owners" do
    project_owner = create :project_owner, :with_notifications
    comment_user  = create :user, :without_notifications
    comment_users = CommentMailerHelper.get_project_users(project(project_owner, comment_user))
    expect(comment_users.first.id).to eq project_owner.id
    expect(comment_users.length).to eq 1
  end
  it "sends an emails when email alerts are enabled only for commenters" do
    project_owner = create :project_owner, :without_notifications
    comment_user  = create :user, :with_notifications
    comment_users = CommentMailerHelper.get_project_users(project(project_owner, comment_user))
    expect(comment_users.first.id).to eq comment_user.id
    expect(comment_users.length).to eq 1
  end

  private

  def project(project_owner, comment_user)
    organization = build(:organization)
    project = create(:project, project_owner: project_owner, organization: organization)
    project.comments = [create(:project_comment, user: comment_user, project: project)]
    project.save
    project
  end

end



