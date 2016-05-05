require 'spec_helper'

describe Event do
  let(:organization) { create :organization }
  subject { create :event }
  it "should require a start date" do
    should validate_presence_of(:start_date)
  end

  it "should require an end date" do
    should validate_presence_of(:end_date)
  end

  it "should require a title" do
    should validate_presence_of(:title)
  end

  it "should require a description" do
    should validate_presence_of(:description)
  end

  it "should require a schedule" do
    should validate_presence_of(:schedule)
  end

  it "should require a registration end date" do
    should validate_presence_of(:registration_end_dt)
  end

  it "should require a registration max" do
    should validate_presence_of(:registration_maximum)
  end

  it "should accept a voting end date" do
    should allow_value(Time.now).for(:voting_end_date)
  end

  it "should not accept a non-date for voting end date" do
    should_not allow_value("Some random trash").for(:voting_end_date)
  end

  it "should have many projects" do
    should have_many(:projects)
  end

  it "should have moderators" do
    should have_many(:moderators)
  end

  it "should have many registrations" do
    should have_many(:registrations)
  end

  context "#url" do
    subject { create(:event, organization: organization, title: "A Title") }
    it "generates the proper url" do
      expect(subject.url).to eq("http://lvh.me/events/1-a-title")
    end
  end

  context "#slack_message" do
    subject { create(:event, organization: organization, title: "A Title") }
    it "generates a nice looking slack message" do
      allow(subject).to receive(:url) { "http://example.com" }
      expect(subject.slack_message).to match("A new event has been created: A Title. http://example.com")
    end
  end

  context "input_<date> fields" do
      subject {build :event, start_date: nil, end_date: nil, voting_end_date: nil, volunteer_end_date: nil, registration_end_dt: nil}

      it "input_start_date should return nil if start_date is nil" do
          expect(subject.input_start_date).to be nil
      end

      it "input_end_date should return nil if start_date is nil" do
          expect(subject.input_end_date).to be nil
      end

      it "input_voting_end_date should return nil if start_date is nil" do
          expect(subject.input_voting_end_date).to be nil
      end

      it "input_volunteer_end_date should return nil if start_date is nil" do
          expect(subject.input_volunteer_end_date).to be nil
      end

      it "input_registration_end_dt should return nil if start_date is nil" do
          expect(subject.input_registration_end_dt).to be nil
      end

  end

  describe "when dealing with voting for projects" do
    it "should be able to enable voting for projects" do
      @event = create(:event, voting_end_date: Date.tomorrow, voting_enabled: true, start_date: Date.tomorrow)
      expect(@event.voting_enabled?).to be true
    end

    it "should be able to disable voting for projects" do
      @event = create(:event, voting_end_date: Date.tomorrow, voting_enabled: 0)
      expect(@event.voting_enabled?).to be false
    end

    it "should not allow voting after voting end date" do
      @event = create(:event, voting_end_date: Date.today, voting_enabled: true)
      expect(@event.voting_enabled?).to be false
    end

    it "should not accept votes if event start date has passed" do
      @event = create(:event, start_date: Date.today, voting_enabled: true, voting_end_date: Date.today)
      expect(@event.voting_enabled?).to be false
    end
  end

  describe "when dealing with volunteering for projects" do
    it "should be able to enable volunteers for projects" do
      @event = create(:event, volunteer_end_date: Date.tomorrow, volunteering_enabled: true, end_date: Date.tomorrow)
      expect(@event.volunteering_enabled?).to be true
    end

    it "should be able to disable volunteers for projects" do
      @event = create(:event, volunteer_end_date: Date.tomorrow, volunteering_enabled: false, end_date: Date.tomorrow)
      expect(@event.volunteering_enabled?).to be false
    end

    it "should not allow volunteering after volunteer end date" do
      @event = create(:event, volunteer_end_date: Date.today, volunteering_enabled: true, end_date: Date.tomorrow)
      expect(@event.volunteering_enabled?).to be false
    end

    it "should not accept votes if event end date has passed" do
      @event = create(:event, volunteer_end_date: Date.today, volunteering_enabled: true, end_date: Date.today.advance(:days => -1))
      expect(@event.volunteering_enabled?).to be false
    end

    describe "When dealing with a created event and project" do
      before(:each) do
        @organization = create :organization
        @event = create :event, organization: @organization
        @user = create :user
        @project = create :project, event: @event, organization: @organization
      end

      it "should calculate the number of votes on associated projects" do
        expect(@project.vote_count).to eq 0
        create(:project_rating, project: @project, user: @user)
        expect(@project.vote_count).to eq 1
      end

      it "should calculate the number of volunteers on associated projects" do
        expect(@project.volunteer_count).to eq 0
        create(:project_volunteer, project: @project, user: @user)
        expect(@project.volunteer_count).to eq 1
      end

      it "should properly determine if a user is registered" do
        @event_registration = create(:event_registration, user: @user, event: @event)
        expect(@event.registered?(@user)).to be true
      end

      it "should properly determine the number of registrations remaining" do
        @event_registration = create(:event_registration, user: @user, event: @event)
        expect(@event.registrations_remaining).to eq 125
      end
    end
  end
end
