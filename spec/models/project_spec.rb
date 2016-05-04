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

  context "#slack_message" do
    describe "with an event" do
      subject { create(:project, organization: organization, title: "A Title") }
      it "generates a nice looking slack message" do
        allow(subject).to receive(:url) { "http://example.com" }
        expect(subject.slack_message).to match("A new project A Title has been submitted to the backlog. http://example.com")
      end
    end
    describe "without an event" do
      let(:event) { create(:event,
                           title: "Event Title",
                           start_date: Date.today.advance(:days => 5),
                           voting_enabled: true,
                           voting_end_date: Date.tomorrow)
      }
      subject { create(:project, organization: organization, event: event, title: "A Title") }

      it "generates a nice looking slack message" do
        allow(subject).to receive(:url) { "http://example.com" }
        expect(subject.slack_message).to match("A new project A Title has been submitted for Event Title. http://example.com")
      end

    end
  end
  describe "that belongs to an event" do
    it "should allow votes if event accepts votes" do
      @event = create(:event, start_date: Date.today.advance(:days => 5),
                            voting_enabled: true,
                            voting_end_date: Date.tomorrow)

      @project = create(:project, organization: organization, event: @event)

      expect(@project.voting_allowed?).to be true
    end

    it "should not allow votes if event does not accept votes" do
      @event = create(:event, start_date: Date.today.advance(:days => 5),
                            voting_enabled: true,
                            voting_end_date: Date.today.advance(:days => -2))

      @project = create(:project, organization: organization, event: @event)

      expect(@project.voting_allowed?).to be false
    end

    it "should allow volunteers if event accepts volunteers" do
      @event = create(:event, end_date: Date.today.advance(:days => 5),
                            volunteering_enabled: true,
                            volunteer_end_date: Date.tomorrow)

      @project = create(:project, organization: organization, event: @event)

      expect(@project.volunteering_allowed?).to be true
    end

    it "should not allow volunteers if event accepts volunteers" do
      @event = create(:event, end_date: Date.today.advance(:days => 5),
                            volunteering_enabled: true,
                            volunteer_end_date: Date.yesterday)

      @project = create(:project, organization: organization, event: @event)

      expect(@project.volunteering_allowed?).to be false
    end
  end

  describe "that does not belong to an event" do
    it "should not accept votes" do
      @project = create(:project, organization: organization)
      expect(@project.voting_allowed?).to be false
    end

    it "should not accept volunteers" do
      @project = create(:project, organization: organization)
      expect(@project.volunteering_allowed?).to be false
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
      expect(@project.voted_on?(@user)).to be false
      @project_rating = create(:project_rating, user: @user, project: @project)
      expect(@project.voted_on?(@user)).to be true
    end

    it "should allow voting to be toggled" do
      expect(lambda{@project.toggle_vote(@user)}).to change(ProjectRating, :count).by(1)
      expect(lambda{@project.toggle_vote(@user)}).to change(ProjectRating, :count).by(-1)
    end

    it "should not allow voting to be toggled iff voting ended" do
      expect(lambda{@project.toggle_vote(@user)}).to change(ProjectRating, :count).by(1)
      @event.voting_enabled=false
      expect(lambda{@project.toggle_vote(@user)}).to_not change(ProjectRating, :count)
    end

    it "should determine of a user has volunteered for a project" do
      expect(@project.volunteered_for?(@user)).to be false
      @project_volunteer = create(:project_volunteer, user: @user, project: @project)
      expect(@project.volunteered_for?(@user)).to be true
    end

    it "should allow someone to volunteer or unvolunteer" do
      expect(lambda{@project.volunteer(@user)}).to  change(ProjectVolunteer, :count).by(1)
      expect(lambda{@project.unvolunteer(@user)}).to change(ProjectVolunteer, :count).by(-1)
    end

    it "should not allow volunteering or unvolunteering after volunteering has been disabled" do
      @event.volunteering_enabled=false
      expect(lambda{@project.volunteer(@user)}).to_not change(ProjectVolunteer, :count)

      @event.volunteering_enabled=true
      expect(lambda{@project.volunteer(@user)}).to change(ProjectVolunteer, :count).by(1)

      @event.volunteering_enabled=false
      expect(lambda{@project.unvolunteer(@user)}).to_not change(ProjectVolunteer, :count)
    end
  end

  # Need to get knowledge of GitHub API here. Contact Debbie G at UMN CSE
  it "should associate a github account"
end
