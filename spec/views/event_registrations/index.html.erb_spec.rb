require 'spec_helper'

describe "event_registrations/index" do
  before(:each) do
    assign(:event_registrations, [
      stub_model(EventRegistration),
      stub_model(EventRegistration)
    ])
  end

  it "renders a list of event_registrations" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
