require 'spec_helper'

describe Project do
  let(:organization) { create :organization }
  it "should require a title" do
    should validate_presence_of(:title)
  end
  
  it "should require a description" do
    should validate_presence_of(:description)
  end
  
  it "should allow a project owner or accept none" do
    should allow_value(nil).for(:project_owner)
    should allow_value(1).for(:project_owner_id)
  end
  
  it "should not require a classification" do
    should_not validate_presence_of(:classification)    
  end

  it "should have volunteers" do
    should have_many(:volunteers)
  end
  
  it "should have comments" do
    should have_many(:volunteers)
  end
  
  it "should have ratings" do
    should have_many(:ratings)
  end
  
  it "should belong to an event" do
    should belong_to(:event)
  end
  
  it "should have tags" do
    should have_many(:tags)
  end
      
  describe "that belongs to an event" do
    it "should allow votes if event accepts votes" do
      @event = create(:event, start_date: Date.today.advance(:days => 5),
                            voting_enabled: true,
                            voting_end_date: Date.tomorrow)
                            
      @project = create(:project, organization: organization, event: @event)
      
      @project.voting_allowed?.should be_true
    end
    
    it "should not allow votes if event does not accept votes" do
      @event = create(:event, start_date: Date.today.advance(:days => 5),
                            voting_enabled: true,
                            voting_end_date: Date.today.advance(:days => -2))
                            
      @project = create(:project, organization: organization, event: @event)
      
      @project.voting_allowed?.should be_false
    end
    
    it "should allow volunteers if event accepts volunteers" do
      @event = create(:event, end_date: Date.today.advance(:days => 5),
                            volunteering_enabled: true,
                            volunteer_end_date: Date.tomorrow)
                            
      @project = create(:project, organization: organization, event: @event)
      
      @project.volunteering_allowed?.should be_true
    end
    
    it "should not allow volunteers if event accepts volunteers" do
      @event = create(:event, end_date: Date.today.advance(:days => 5),
                            volunteering_enabled: true,
                            volunteer_end_date: Date.today.advance(:days => -2))
                            
      @project = create(:project, event: @event)
      
      @project.volunteering_allowed?.should be_false
    end    
  end
  
  describe "that does not belong to an event" do
    it "should not accept votes" do
      @project = create(:project, organization: organization)
      @project.voting_allowed?.should be_false      
    end
    
    it "should not accept volunteers" do
      @project = create(:project, organization: organization)
      @project.volunteering_allowed?.should be_false      
    end
  end

  describe "When dealing with a created event and project" do
    before(:each) do
      @event = create(:event, voting_end_date: Date.today.advance(:days => 5),
                              volunteer_end_date: Date.today.advance(:days => 5),
                              registration_end_dt: Date.today.advance(:days => 5),
                              start_date: Date.today.advance(:days => 7),
                              end_date: Date.today.advance(:days => 10))
      @user = create(:user)
      @project = create(:project, organization: organization, :event => @event)
    end

    it "should determine if a user has voted on a project" do 
      @project.voted_on?(@user).should be_false
      @project_rating = create(:project_rating, user: @user, project: @project)
      @project.voted_on?(@user).should be_true
    end

    it "should allow voting to be toggled" do
      lambda{@project.toggle_vote(@user)}.should change(ProjectRating, :count).by(1)
      lambda{@project.toggle_vote(@user)}.should change(ProjectRating, :count).by(-1)
    end

    it "should not allow voting to be toggled if voting ended" do
      lambda{@project.toggle_vote(@user)}.should change(ProjectRating, :count).by(1)
      @event.voting_enabled=false
      lambda{@project.toggle_vote(@user)}.should_not change(ProjectRating, :count).by(-1)
    end

    it "should determine of a user has volunteered for a project" do
      @project.volunteered_for?(@user).should be_false
      @project_volunteer = create(:project_volunteer, user: @user, project: @project)
      @project.volunteered_for?(@user).should be_true
    end

    it "should allow someone to volunteer or unvolunteer" do
      lambda{@project.volunteer(@user)}.should change(ProjectVolunteer, :count).by(1)
      lambda{@project.unvolunteer(@user)}.should change(ProjectVolunteer, :count).by(-1)
    end

    it "should not allow volunteering or unvolunteering after volunteering has been disabled" do
      @event.volunteering_enabled=false
      lambda{@project.volunteer(@user)}.should_not change(ProjectVolunteer, :count).by(1)

      @event.volunteering_enabled=true
      lambda{@project.volunteer(@user)}.should change(ProjectVolunteer, :count).by(1)

      @event.volunteering_enabled=false
      lambda{@project.unvolunteer(@user)}.should_not change(ProjectVolunteer, :count).by(-1)      
    end
  end
  
  # Need to get knowledge of GitHub API here. Contact Debbie G at UMN CSE
  it "should associate a github account"
end
