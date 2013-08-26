require 'spec_helper'

describe "event_registrations/edit" do
  before(:each) do
    @event_registration = assign(:event_registration, stub_model(EventRegistration))
  end

  it "renders the edit event_registration form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", event_registration_path(@event_registration), "post" do
    end
  end
end
