require_relative '../spec_helper'
require 'uri'

describe ProjectCommentsController, :type => :controller do
  before(:each) do
    ActionMailer::Base.clear_cache
  end

  def sign_in_as(user)
    ApplicationController.any_instance.stub(:current_user).and_return user
    session[:created_at] = Time.now
  end

  it "sends an emails when email alerts are enabled for everyone" do
    project_comment_init(:commenter_with_alert, :owner_with_alert)
    post :create, project_comment(@project.id)
    ActionMailer::Base.cached_deliveries.count.should eq(2)
    ActionMailer::Base.cached_deliveries.first.to.should eq(['owner_with_alert@example.com'])
    ActionMailer::Base.cached_deliveries.last.to.should  eq(['commenter_with_alert@example.com'])
  end

  it "does not send emails when email alerts are disabled for everyone" do
    project_comment_init(:commenter_without_alert, :owner_without_alert)
    post :create, project_comment(@project.id)
    ActionMailer::Base.deliveries.count.should eq(0)
  end

  it "sends an emails when email alerts are enabled only for project owners" do
    project_comment_init(:commenter_without_alert, :owner_with_alert)
    post :create, project_comment(@project.id)
    ActionMailer::Base.cached_deliveries.count.should eq(1)
    ActionMailer::Base.cached_deliveries.first.to.should eq(['owner_with_alert@example.com'])
  end

  it "sends an emails when email alerts are enabled only for commenters" do
    project_comment_init(:commenter_with_alert, :owner_without_alert)
    post :create, project_comment(@project.id)
    ActionMailer::Base.cached_deliveries.count.should eq(1)
    ActionMailer::Base.cached_deliveries.first.to.should eq(['commenter_with_alert@example.com'])
  end

  def project_comment(project_id)
    {:project_id => project_id, :project_comment => FactoryGirl.attributes_for(:project_comment).except(:user_id)}
  end

  def project_comment_init(commenter_type, owner_type)
    @user = create(commenter_type)
    sign_in_as(@user)
    @project = create(:project)
    @project.project_owner = create(owner_type)
    @project.save!
  end
end



