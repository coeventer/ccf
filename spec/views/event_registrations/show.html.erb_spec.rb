require 'spec_helper'

describe "event_registrations/show" do
  before(:each) do
    @event_registration = assign(:event_registration, stub_model(EventRegistration))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
